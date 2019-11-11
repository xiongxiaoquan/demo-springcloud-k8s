package com.springcloud.springbootprovider.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ServerController {

    @GetMapping("/jiraIssueDesc")
    public String issueDesc(){
        return "this is from service-provider message";
    }
}
