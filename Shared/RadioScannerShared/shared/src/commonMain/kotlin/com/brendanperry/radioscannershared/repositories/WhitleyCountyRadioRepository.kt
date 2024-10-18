package com.brendanperry.radioscannershared.repositories

import com.brendanperry.radioscannershared.models.Recording
import com.brendanperry.radioscannershared.sources.HttpClient
import com.fleeksoft.ksoup.Ksoup
import io.ktor.client.request.get
import io.ktor.client.statement.bodyAsText

class WhitleyCountyRadioRepository {
    private fun intToTwoCharacterString(value: Int): String {
        return if (value < 10) {
            "0$value"
        } else {
            "$value"
        }
    }

    suspend fun getRecordingsFor(day: Int, month: Int, year: Int, hour: Int): Array<Recording> {
        val twoDigitYear = year % 100
        val formattedYear = intToTwoCharacterString(twoDigitYear)
        val formattedMonth = intToTwoCharacterString(month)
        val formattedDay = intToTwoCharacterString(day)
        val formattedHour = intToTwoCharacterString(hour)
        val client = HttpClient.client

        val response =
            client.get("https://scanwc.com/assets/php/archives/getfields.php?y=$formattedYear&m=$formattedMonth&d=$formattedDay&h=$formattedHour&g=undefined&f=undefined&s=undefined")
        val html = response.bodyAsText()

        val document = Ksoup.parse(html)

        val recordings = arrayListOf<Recording>()

        document.getElementsByClass("archives_files").first()?.let {
            it.children().forEach { html ->
                val recording = Recording(html.text(), html.value())
                recordings.add(recording)
            }
        }

        return recordings.toTypedArray()
    }
}
