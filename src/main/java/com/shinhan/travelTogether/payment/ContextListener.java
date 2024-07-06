package com.shinhan.travelTogether.payment;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class ContextListener implements ServletContextListener {
	@Override
    public void contextInitialized(ServletContextEvent sce) {
        EnvConfig envConfig = new EnvConfig();
        sce.getServletContext().setAttribute("envConfig", envConfig);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Do nothing
    }
}