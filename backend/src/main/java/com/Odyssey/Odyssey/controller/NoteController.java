package com.Odyssey.Odyssey.controller;


import com.Odyssey.Odyssey.model.Note;
import com.Odyssey.Odyssey.repository.NoteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/notes")
public class NoteController {
    @Autowired
    private NoteRepository noteRepository;

    @PostMapping
    public Note createNote(@RequestBody Note note) {
        return noteRepository.save(note);
    }

    @GetMapping
    public List<Note> getAllNotes() {
        return noteRepository.findAll();
    }

    @DeleteMapping("/{id}")
    public void deleteNote(@PathVariable Long note_id) {
        noteRepository.deleteById(note_id);
    }
}

