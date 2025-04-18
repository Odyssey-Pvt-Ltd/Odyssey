package com.Odyssey.Odyssey.model;

import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;
import java.time.LocalDateTime;


@Entity
@Table(name = "notes")
public class Note {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long note_id;

    private String title;
    private String content;

    @CreationTimestamp
    private LocalDateTime createdAt;



    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Long getNote_id() {
        return note_id;
    }

    public void setNote_id(Long id) {
        this.note_id = id;
    }

}

