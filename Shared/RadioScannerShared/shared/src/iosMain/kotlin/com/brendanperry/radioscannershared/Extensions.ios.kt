package com.brendanperry.radioscannershared

import kotlinx.cinterop.ExperimentalForeignApi
import kotlinx.cinterop.convert
import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.toNSDateComponents
import platform.Foundation.NSDateComponents


@OptIn(ExperimentalForeignApi::class)
fun LocalDateTime.toNSDateComponents(): NSDateComponents {
    val components = date.toNSDateComponents()
    components.hour = hour.convert()
    components.minute = minute.convert()
    components.second = second.convert()
    components.nanosecond = nanosecond.convert()
    return components
}