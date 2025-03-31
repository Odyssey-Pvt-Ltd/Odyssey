package com.Odyssey.Odyssey.controller;

import com.Odyssey.Odyssey.service.AIChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;

import java.util.Map;

@RestController
@RequestMapping("/api/chat")
public class AIChatController {

    @Autowired
    private AIChatService aiChatService;

    @PostMapping
    public Mono<ResponseEntity<Map<String, String>>> chat(@RequestBody Map<String, String> request) {
        String message = request.get("message");
        return aiChatService.chatWithAI(message)
                .map(response -> ResponseEntity.ok(Map.of("response", response)));
    }
}