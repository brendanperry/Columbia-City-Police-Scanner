package com.brendanperry.radioscannershared.repositories

import com.brendanperry.radioscannershared.models.Recording
import com.fleeksoft.ksoup.Ksoup
import com.fleeksoft.ksoup.network.parseGetRequest

class WhitleyCountyRadioRepository {
    suspend fun getRecordingsFor(day: Int, month: Int, year: Int, hour: Int): Array<Recording> {
        val document =
            Ksoup.parseGetRequest(url = "https://scanwc.com/assets/php/archives/getfields.php?y=$year&m=$month&d=$day&h=$hour&g=undefined&f=undefined&s=undefined")

        val recordings = arrayListOf<Recording>()

        document.getElementsByClass("archive_files").first()?.let {
            it.children().forEach { html ->
                val recording = Recording(html.text(), html.value())
                recordings.add(recording)
            }
        }

        return recordings.toTypedArray()
    }
}
