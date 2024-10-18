package com.brendanperry.radioscannershared

import com.brendanperry.radioscannershared.repositories.WhitleyCountyRadioRepository
import kotlinx.coroutines.runBlocking
import kotlin.test.Test

class CommonGreetingTest {

    @Test
    fun testExample() {
//        assertTrue(Greeting().greet().contains("Hello"), "Check 'Hello' is mentioned")

        val radioRepository = WhitleyCountyRadioRepository()

        runBlocking {
            val result = radioRepository.getRecordingsFor(16, 10, 2024, 8)

//            result.forEach { recording ->
//                val name = recording.title
//                print(name)
//            }
            println(result)
        }
    }
}