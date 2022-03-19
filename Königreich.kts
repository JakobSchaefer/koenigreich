import kotlin.math.max
import kotlin.math.floor

typealias Taler = Int

open class Einwohner(val einkommen: Taler) {
    open fun zuVersteuerndesEinkommen(): Taler {
        return einkommen
    }
    open fun steuer(): Taler {
        val zvE = zuVersteuerndesEinkommen()
        return max(1, floor(zvE * 0.1).toInt())
    }
}

class Bauer(einkommen: Taler) : Einwohner(einkommen)

class Adel(einkommen: Taler) : Einwohner(einkommen) {
    override fun steuer(): Taler {
        return max(20, super.steuer())
    }
}

class Leibeigener(einkommen: Taler) : Einwohner(einkommen) {
    override fun zuVersteuerndesEinkommen(): Taler {
        return max(0, einkommen - 12)
    }
}

class König(einkommen: Taler) : Einwohner(einkommen) {
    override fun steuer(): Taler {
        return 0
    }
}

class Königreich {
    fun steuerBescheid(einwohner: Einwohner) {
        println("""
            |Einwohner = ${einwohner::class.simpleName}
            |Einkommen = ${einwohner.einkommen} Taler
            |zvE       = ${einwohner.zuVersteuerndesEinkommen()} Taler
            |Steuer    = ${einwohner.steuer() } Taler
            |""".trimMargin())
    }
}

val königreich = Königreich()
val einkommensteuererklärungen = listOf(
    König(10_000),
    Bauer(30),
    Adel(100),
    Leibeigener(15)
)
for (e in einkommensteuererklärungen) {
    königreich.steuerBescheid(e)
}
