package com.springcloud.springbootweb.Controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class ServerController {

    @GetMapping("/implement")
    public String issueDesc(){
//        RestTemplate restTemplate = new RestTemplate();
//        String res=restTemplate.getForObject("http://localhost:8081/jiraIssueDesc",String.class);
//        System.out.print(res+"111");
        return getIssueDesc();
//        return  res;
    }

    @GetMapping("/test")
    public String test(){
        return "this is a test message!";
    }

    @Autowired
    private RestTemplate restTemplate;

    public String getIssueDesc(){
        String res = restTemplate.getForObject("http://service-provider/jiraIssueDesc",String.class);
        return res;
    }
}
