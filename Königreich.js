function zuVersteuerndesEinkommen(einwohner, einkommen) {
    switch (einwohner) {
        case "Leibeigener":
            return Math.max(0, einkommen - 12)
        default:
            return einkommen
    }
}

function steuer(einwohner, einkommen) {
    const zvE = zuVersteuerndesEinkommen(einwohner, einkommen)
    const grundsteuer = Math.max(1, Math.floor(einkommen * 0.1))
    switch (einwohner) {
        case "König":
            return 0
        case "Adel":
            return Math.max(20, grundsteuer)
        default:
            return grundsteuer
    }
}

function steuerBescheid(einwohner, einkommen) {
    const zvE = zuVersteuerndesEinkommen(einwohner, einkommen)
    const steuerbetrag = steuer(einwohner, einkommen)
    console.log(`Einwohner = ${einwohner}`)
    console.log(`Einkommen = ${einkommen} Taler`)
    console.log(`zvE       = ${zvE} Taler`)
    console.log(`Steuer    = ${steuerbetrag} Taler`)
    console.log()
}

const fs = require('fs')
const readline = require('readline')

async function main() {
    const csv = fs.createReadStream('Einkommensteuererklärungen.csv')
    const lines = readline.createInterface({
        input: csv
    })
    let atFirstLine = true
    for await (const line of lines) {
        if (atFirstLine) {
            atFirstLine = false
            continue
        } else {
            const [einwohner, einkommen] = line.split(',')
            steuerBescheid(einwohner, einkommen)
        }
    }
}

main()
