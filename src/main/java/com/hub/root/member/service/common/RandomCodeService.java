package com.hub.root.member.service.common;

import java.util.Random;

import org.springframework.stereotype.Service;

@Service
public class RandomCodeService {

	public int randomNumber() {
    	Random random = new Random();
    	int num = 1000 + random.nextInt(9000);
    	System.out.println("num : " + num);
    	return num;
    }
}
