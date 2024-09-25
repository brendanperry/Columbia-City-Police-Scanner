package com.brendanperry.radioscannershared

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform