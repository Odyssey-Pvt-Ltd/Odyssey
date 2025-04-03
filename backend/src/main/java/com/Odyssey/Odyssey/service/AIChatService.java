package com.Odyssey.Odyssey.service;

import com.Odyssey.Odyssey.config.DeepSeekConfig;
import com.Odyssey.Odyssey.dto.DeepSeekRequest;
import com.Odyssey.Odyssey.dto.DeepSeekResponse;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.util.Collections;

@Service
public class AIChatService {

    private final WebClient webClient;
    private final DeepSeekConfig deepSeekConfig;

    public AIChatService(DeepSeekConfig deepSeekConfig) {
        this.deepSeekConfig = deepSeekConfig;
        this.webClient = WebClient.builder()
                .baseUrl(deepSeekConfig.getApiUrl())
                .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .defaultHeader(HttpHeaders.AUTHORIZATION, "Bearer " + deepSeekConfig.getApiKey())
                .build();
    }

    public Mono<String> chatWithAI(String userMessage) {
        DeepSeekRequest.Message message = new DeepSeekRequest.Message();
        message.setRole("user");
        message.setContent(userMessage);

        DeepSeekRequest request = new DeepSeekRequest();
        request.setModel("deepseek-chat"); // or whatever model you're using
        request.setMessages(Collections.singletonList(message));

        return webClient.post()
                .bodyValue(request)
                .retrieve()
                .bodyToMono(DeepSeekResponse.class)
                .map(response -> {
                    if (response.getChoices() != null && response.getChoices().length > 0) {
                        return response.getChoices()[0].getMessage().getContent();
                    }
                    return "Sorry, I couldn't process your request.";
                });
    }
}