package com.cta.boir.jobs;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.cta.boir.service.SchedulerService;

import jakarta.mail.MessagingException;

@Component
public class MyScheduler {

	@Autowired
	private SchedulerService schedulerService;
	/*
	 * 
	 * @Scheduled(fixedRate = 10000): runs the task at a fixed rate (e.g., every 10
	 * seconds)
	 * 
	 * @Scheduled(fixedDelay = 10000): runs the task with a fixed delay between
	 * executions (e.g., every 10 seconds)
	 * 
	 * @Scheduled(cron = "0 0 12 * * *"): runs the task at a specific time (e.g.,
	 * every day at 12:00 PM)
	 * 
	 * @Scheduled(initialDelay = 10000, fixedRate = 10000): runs the task with an
	 * initial delay and then at a fixed rate
	 */

	@Scheduled(cron = "0 0 3 1 12 *") // run every 10 seconds
	public void myTask() throws MessagingException {
 		schedulerService.sendPendingReminders();
		schedulerService.sendBeneficialPendingReminders();
	}

}