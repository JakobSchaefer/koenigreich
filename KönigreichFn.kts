import kotlin.math.max
import kotlin.math.floor

typealias Taler = Int

sealed interface Einwohner
class Bauer : Einwohner
class Adel : Einwohner
class Leibeigener : Einwohner
class König : Einwohner

fun zuVersteuerndesEinkommen(einwohner: Einwohner, einkommen: Taler): Taler {
    return when (einwohner) {
        is Leibeigener -> max(0, einkommen - 12)
        else -> einkommen
    }
}

fun steuer(einwohner: Einwohner, einkommen: Taler): Taler {
    val grundsteuer = max(1, floor(einkommen * 0.1).toInt())
    return when (einwohner) {
        is König -> 0
        is Adel -> max(20, grundsteuer)
        else -> grundsteuer
    }
}

fun steuerBescheid(einwohner: Einwohner, einkommen: Taler) {
    println("""
        Einwohner = ${einwohner::class.simpleName}
        Einkommen = ${einkommen} Taler
        zvE       = ${zuVersteuerndesEinkommen(einwohner, einkommen)} Taler
        Steuer    = ${steuer(einwohner, einkommen) } Taler

        """.trimIndent())
}

val einkommensteuererklärungen = listOf(
    König() to 10_000,
    Bauer() to 30,
    Adel() to 100,
    Leibeigener() to 15
)

for ((einwohner, einkommen) in einkommensteuererklärungen) {
    steuerBescheid(einwohner, einkommen)
}