package com.acme.menagerie.dao;

import javax.sql.DataSource;

import liquibase.Liquibase;
import liquibase.database.Database;
import liquibase.database.DatabaseFactory;
import liquibase.database.jvm.JdbcConnection;
import liquibase.integration.spring.SpringLiquibase;
import liquibase.logging.LogFactory;
import liquibase.resource.ClassLoaderResourceAccessor;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;
import org.springframework.transaction.PlatformTransactionManager;

@Configuration
public class PetRepositoryTestConfig {

    @Bean
    public PetRepository petRepository() throws Exception {
        PetRepository petRepository = new PetRepository();
        petRepository.setDataSource(dataSource());
        return petRepository;
    }

    @Bean
    public Liquibase liquibase() throws Exception {
        Database database = DatabaseFactory.getInstance().findCorrectDatabaseImplementation(new JdbcConnection(dataSource().getConnection()));        
        Liquibase liquibase = new Liquibase("changelog.xml", new ClassLoaderResourceAccessor(), database);
        return liquibase;
    }

    @Bean
    public SpringLiquibase springLiquibase() throws Exception {
        LogFactory.getLogger().setLogLevel("info", "target/liquibase.log");
        SpringLiquibase liquibase = new SpringLiquibase();
        liquibase.setChangeLog("classpath:changelog.xml");
        liquibase.setDataSource(dataSource());
        liquibase.setDropFirst(false);
        liquibase.setContexts("test");
        return liquibase;
    }

    @Bean()
    public DataSource dataSource() throws Exception {
        SingleConnectionDataSource dataSource = new SingleConnectionDataSource();
        dataSource.setDriverClassName("org.h2.Driver");
        dataSource.setUrl("jdbc:h2:mem:test");
        dataSource.setUsername("sa");
        dataSource.setPassword("sa");
        dataSource.setSuppressClose(true);
        return dataSource;
    }
    
    @Bean
    public PlatformTransactionManager transactionManager() throws Exception {
        return new DataSourceTransactionManager(dataSource());
    }
}
