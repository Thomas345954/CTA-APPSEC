package com.cta.boir.service;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cta.boir.repository.CustomRepository;

@Service
public class CustomEntityService {

    @Autowired
    private CustomRepository customRepository;
 

    public List<Map<String, Object>> getDynamicQueryResults(String sql, Map<String, Object> parameters) {
        return customRepository.executeDynamicNativeQuery(sql, parameters);
    }
}
