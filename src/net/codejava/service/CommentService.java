package net.codejava.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import net.codejava.repository.CommentRepository;

@Service
@Transactional
public class CommentService {
    @Autowired
    private CommentRepository commentRepo;
}
