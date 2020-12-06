import System.IO

convert :: Char -> String -> Int
convert _ "" = 0
convert c s@(a:as) = x + convert c as where
  x = if c == a then 2 ^ (length s - 1) else 0

getSeats :: Handle -> [Int] -> IO [Int]
getSeats handle seats = do
  eof <- hIsEOF handle
  if eof
    then return seats
    else do
      line <- hGetLine handle
      let r = convert 'B' $ take 7 line
      let c = convert 'R' $ drop 7 line
      let s = r * 8 + c
      -- putStrLn $ line ++ " => row " ++ show r ++ ", col " ++ show c ++ ", id " ++ show s
      getSeats handle (s:seats)

main = do
  handle <- openFile "seatcodes.txt" ReadMode
  seats <- getSeats handle []
  print $ maximum seats