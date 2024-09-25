package com.brendanperry.radioscannershared.sources

import io.ktor.client.HttpClient
import io.ktor.client.plugins.BrowserUserAgent
import io.ktor.client.plugins.cache.HttpCache

object HttpClient {
    val client = HttpClient {
        BrowserUserAgent()
        install(HttpCache)
    }
}