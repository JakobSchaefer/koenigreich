defmodule Koenigreich do
  def zuVersteuerndesEinkommen(einwohner, einkommen) do
    case einwohner do
      :leibeigener -> max(0, einkommen - 12)
      _ -> einkommen
    end
  end

  def steuer(einwohner, einkommen) do
    zvE = zuVersteuerndesEinkommen(einwohner, einkommen)
    grundsteuer = max(1, floor(zvE * 0.1))

    case einwohner do
      :koenig -> 0
      :adel -> max(20, grundsteuer)
      _ -> grundsteuer
    end
  end

  def steuerBescheid(einwohner, einkommen) do
    zvE = zuVersteuerndesEinkommen(einwohner, einkommen)
    steuerbetrag = steuer(einwohner, einkommen)

    IO.puts("""
    Einwohner = #{einwohner}
    Einkommen = #{einkommen} Taler
    zvE       = #{zvE} Taler
    Steuer    = #{steuerbetrag} Taler
    """)
  end
end

einkommenssteuererklaerungen = [
  {:koenig, 10_000},
  {:bauer, 30},
  {:adel, 100},
  {:leibeigener, 15}
]

Enum.each(
  einkommenssteuererklaerungen,
  fn {einwohner, einkommen} -> Koenigreich.steuerBescheid(einwohner, einkommen) end
)
