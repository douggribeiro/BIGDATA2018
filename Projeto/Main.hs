-- ghc -o Main Main.hs ; ./Main ; rm Main

-- Importar bibliotecas de importancia
import Data.List (nub, elemIndices)
import qualified Data.Map as M
import Data.Map (Map, (!))
import Data.List (transpose)
import Text.CSV

-- Novos tipos
type Classe = String
type Atributo = String
type Entropia = Double
type DataSet = [([String], Classe)]

-- Classeifying a dataset using a decision tree
main = do
  arquivoCSV <- parseCSVFromFile "input.csv"
  either (error "Arquivo Invalido! Nao eh CSV") iniciaProcesso arquivoCSV


iniciaProcesso csv = do
  let limpaCSV = filter (\x -> length x > 1)
  let dadosCSV = map (\x -> (init x, last x)) $ limpaCSV csv
  print $ dtree "root" dadosCSV

amostras :: DataSet -> [[String]]
amostras d = map fst d

classes :: DataSet -> [String]
classes d = map snd d

calculaEntropia :: (Eq a) => [a] -> Entropia
calculaEntropia xs = sum $ map (\x -> probabilidade x * info x) $ nub xs
  where probabilidade x = (length' (elemIndices x xs)) / (length' xs)
        info x = negate $ logBase 2 (probabilidade x)
        length' xs = fromIntegral $ length xs

splitAttr :: [(Atributo, Classe)] -> Map Atributo [Classe]
splitAttr fc = foldl (\m (f,c) -> M.insertWith (++) f [c] m) M.empty fc

splitEntropia :: Map Atributo [Classe] -> M.Map Atributo Entropia
splitEntropia m = M.map calculaEntropia m

informationGain :: [Classe] -> [(Atributo, Classe)] -> Double
informationGain s a = calculaEntropia s - newInformation
  where eMap = splitEntropia $ splitAttr a
        m = splitAttr a
        toDouble x = read x :: Double
        ratio x y = (fromIntegral x) / (fromIntegral y)
        sumE = M.map (\x -> (fromIntegral.length) x / (fromIntegral.length) s) m
        newInformation = M.foldWithKey (\k a b -> b + a*(eMap!k)) 0 sumE

highestInformationGain :: DataSet -> Int
highestInformationGain d = snd $ maximum $ 
  zip (map ((informationGain . classes) d) attrs) [0..]
  where attrs = map (attr d) [0..s-1]
        attr d n = map (\(xs,x) -> (xs!!n,x)) d
        s = (length . fst . head) d
        

data DTree = DTree { feature :: String
                   , children :: [DTree] } 
           | Node String String
           deriving Show

datatrees :: DataSet -> Map String DataSet
datatrees d = 
  foldl (\m (x,n) -> M.insertWith (++) (x!!i) [((x `dropAt` i), fst (cs!!n))] m)
    M.empty (zip (amostras d) [0..])
  where i = highestInformationGain d
        dropAt xs i = let (a,b) = splitAt i xs in a ++ drop 1 b
        cs = zip (classes d) [0..]

allEqual :: Eq a => [a] -> Bool
allEqual [] = True
allEqual [x] = True
allEqual (x:xs) = x == (head xs) && allEqual xs

dtree :: String -> DataSet -> DTree
dtree f d 
  | allEqual (classes d) = Node f $ head (classes d)
  | otherwise = DTree f $ M.foldWithKey (\k a b -> b ++ [dtree k a] ) [] (datatrees d)


