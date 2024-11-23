package com.brendanperry.radioscannershared

import com.brendanperry.radioscannershared.repositories.CCPoliceActivityRepository
import kotlin.test.Test
import kotlin.test.assertTrue

class CCPoliceActivityRepositoryTest {
    @Test
    fun testBuildingLogFromPdfString() {
        val repository = CCPoliceActivityRepository()

        val log = repository.readPdfStringData(
            "Reported Nature Incident address\n00:12:35 09/11/24 Foot Ptrl Nbrhd\n00:23:27 09/11/24 Traffic Stop W US 30 EB & N TEST LAKE BLVD\n00:31:20 09/11/24 Susp Vehicle 2XX N TESTING RD\n01:55:19 09/11/24 Traffic Stop W US 30 EB & N TESTING DR\n02:19:20 09/11/24 Traffic Stop E US 30 EB & S 250 W\n02:32:45 09/11/24 Traffic Stop W US 30 EB & W TESTING DR\n02:41:15 09/11/24 Foot Ptrl Busn\n04:53:11 09/11/24 Traffic Hazard S TESTING ST & W TESTER AVE\n05:49:38 09/11/24 Ast Fire 2XX E TEST ST\n07:26:44 09/11/24 SRO Activity 12XX W SR 33\n07:40:38 09/11/24 SRO Activity 11XX N SR 78\n07:50:02 09/11/24 Foot Ptrl Nbrhd\n08:08:34 09/11/24 SRO Activity 10XX N SR 89\n08:32:54 09/11/24 Susp Vehicle 1XX W TEST ST\n09:24:15 09/11/24 SRO Activity 4XX E TESTER ST\n09:38:54 09/11/24 Foot Ptrl Busn\n09:51:56 09/11/24 Ast EMS 12XX N SR 23\n09:54:07 09/11/24 SRO Activity 19XX W SR 34\n10:18:58 09/11/24 SRO Activity 10XX N SR 56\n10:25:48 09/11/24 Foot Ptrl Busn\n10:28:34 09/11/24 SRO Activity 78XX N SR 119\n10:28:46 09/11/24 SRO Activity 13XX S SR 11\n10:48:54 09/11/24 Traffic Stop 9XX W TESTER ST\n10:53:49 09/11/24 Traffic Stop W US 30 EB & N TESTER DR\n11:10:39 09/11/24 Foot Ptrl Busn\n11:18:19 09/11/24 Traffic Stop E TEST ST & S TESTING ST\n11:29:08 09/11/24 Traffic Stop E US 30 EB & E SR 215\n11:31:56 09/11/24 SRO Activity 2XX S 555 E\n11:33:38 09/11/24 Foot Ptrl Busn\n12:14:24 09/11/24 Traffic Stop S SR 55 & S 51 N\n12:31:01 09/11/24 Traffic Stop E TESTER ST & N TEST AVE\n12:32:50 09/11/24 SRO Activity 11XX N SR 12\n13:02:04 09/11/24 Traffic Stop S TEST ST & E TESTING ST\n14:11:49 09/11/24 SRO Activity 1XX S SR 99\n14:37:06 09/11/24 Theft Vehicle 1XX E TEST RD\n14:37:29 09/11/24 SRO Activity 6XX S SR 45\n15:25:51 09/11/24 Juvenile 1XX N TEST ST\n15:45:20 09/11/24 Welfare Check 5XX S TEST ST\n18:16:07 09/11/24 Vehicle Lockout 7XX W TESTING ST\n18:39:30 09/11/24 Traffic Stop W US 30 EB & N TESTING DR\n18:40:10 09/11/24 Traffic Stop W US 30 EB & W TEST RD\n19:02:08 09/11/24 Traffic Stop W US 30 EB & N TEST DR\n19:18:26 09/11/24 Traffic Stop W US 30 EB & W TESTER RD\n19:39:14 09/11/24 Traffic Stop W US 30 EB & W TESTER RD\n19:53:20 09/11/24 Crim Trespass 9XX W TEST BLVD\n20:10:16 09/11/24 Disturb Domest 0XX N TEST DR\n20:48:14 09/11/24 Unwanted Party 5XX S TEST DR\n21:50:15 09/11/24 Traffic Stop E US 30 EB & S 555 E\n22:24:59 09/11/24 Traffic Stop TEST ST & E TEST ST\n22:34:51 09/11/24 Traffic Stop S TEST ST & W TEST ST\n23:04:10 09/11/24 Traffic Stop E US 30 EB & E SR 5\n23:40:11 09/11/24 Traffic Stop W US 30 EB & W TESTER RD\n11/7/2024 7:08:24 AM Page 1 of 1",
            1,
            1,
            24
        )

        assertTrue {
            log?.reportedActivity?.count() == 52
        }
    }
}