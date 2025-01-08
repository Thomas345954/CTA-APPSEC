package com.cta.boir.repository;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

@Repository
public class CustomRepository {

    @PersistenceContext
    private EntityManager entityManager;

    public List<Map<String, Object>> executeDynamicNativeQuery(String sql, Map<String, Object> parameters) {
        Query query = entityManager.createNativeQuery(sql);

        // Set parameters dynamically
        if (parameters != null) {
            for (Map.Entry<String, Object> entry : parameters.entrySet()) {
                query.setParameter(entry.getKey(), entry.getValue());
            }
        }

        List<Object[]> resultList = query.getResultList();
        List<Map<String, Object>> resultMapList = new ArrayList<>();

        if (!resultList.isEmpty()) {
            // Unwrapping Hibernate Session and using JDBC Connection
            entityManager.unwrap(Session.class).doWork(connection -> {
                try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
                    ResultSetMetaData rsmd = rs.getMetaData();
                    int columnCount = rsmd.getColumnCount();

                    for (Object[] row : resultList) {
                        Map<String, Object> map = new HashMap<>();
                        for (int i = 0; i < columnCount; i++) {
                            String columnName = rsmd.getColumnLabel(i + 1); // Column names start from index 1 in JDBC
                            map.put(columnName, row[i]);
                        }
                        resultMapList.add(map);
                    }
                }
            });
        }

        return resultMapList;
    }
}
