type Taler = Integer

data Einwohner
  = Bauer
  | Adel
  | Leibeigener
  | König
  deriving (Show)

zuVersteuerndesEinkommen :: Einwohner -> Taler -> Taler
zuVersteuerndesEinkommen einwohner einkommen =
  case einwohner of
    Leibeigener -> max 0 (einkommen - 12)
    _ -> einkommen

steuer :: Einwohner -> Taler -> Taler
steuer einwohner einkommen =
  let zvE = zuVersteuerndesEinkommen einwohner einkommen
      grundsteuer = floor (fromInteger zvE * 0.1)
   in case einwohner of
        König -> 0
        Adel -> max 20 grundsteuer
        _ -> max 1 grundsteuer

steuerBescheid :: Einwohner -> Taler -> IO ()
steuerBescheid einwohner einkommen = do
  putStrLn $
    unlines
      [ "Einwohner = " ++ show einwohner,
        "Einkommen = " ++ show einkommen,
        "zvE       = " ++ show zvE,
        "Steuer    = " ++ show steuerbetrag
      ]
  where
    zvE = zuVersteuerndesEinkommen einwohner einkommen
    steuerbetrag = steuer einwohner einkommen

main :: IO ()
main = do
  let steuererklärungen =
        [ (König, 85000),
          (Bauer, 650),
          (Adel, 15000),
          (Leibeigener, 20)
        ]
  mapM_ (uncurry steuerBescheid) steuererklärungen