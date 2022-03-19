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
      grundsteuer = max 1 (floor (fromInteger zvE * 0.1))
   in case einwohner of
        König -> 0
        Adel -> max 20 grundsteuer
        _ -> grundsteuer

steuerBescheid :: Einwohner -> Taler -> IO ()
steuerBescheid einwohner einkommen = do
  putStrLn $
    unlines
      [ "Einwohner = " ++ show einwohner,
        "Einkommen = " ++ show einkommen ++ " Taler",
        "zvE       = " ++ show zvE ++ " Taler",
        "Steuer    = " ++ show steuerbetrag ++ " Taler"
      ]
  where
    zvE = zuVersteuerndesEinkommen einwohner einkommen
    steuerbetrag = steuer einwohner einkommen

main :: IO ()
main = do
  let steuererklärungen =
        [ (König, 10000),
          (Bauer, 30),
          (Adel, 100),
          (Leibeigener, 15)
        ]
  mapM_ (uncurry steuerBescheid) steuererklärungen