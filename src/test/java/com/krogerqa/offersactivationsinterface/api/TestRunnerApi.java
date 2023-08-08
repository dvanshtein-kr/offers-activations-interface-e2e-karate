package com.krogerqa.offersactivationsinterface.api;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.krogerqa.karatecentral.utilities.BaseTestRunner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class TestRunnerApi extends BaseTestRunner {
    public static int threadCount = 999; // 0/1 - Sequential Execution
//
////      Extend Report
//    @Test
//    public void Features() throws IOException {
//        Results results = Runner.path("src/test/java/com/storePriceKarate/test/promotions.feature")
//    .outputCucumberJson(true)
//                .tags("@storeprice")
//                .parallel(threadCount);
//        assertEquals(0, results.getFailCount(), results.getErrorMessages());
//    }


    @Test
    public void globalMessageApiTest() {
        Results results = Runner.path("src/test/java/com/krogerqa/globalMessage/api")
                .outputJunitXml(true)
                .outputHtmlReport(false)
                .outputCucumberJson(true)
                .tags("@smoke")
                .parallel(1);
        assertEquals(0, results.getFailCount());
    }
}
