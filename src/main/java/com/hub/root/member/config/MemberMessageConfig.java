package com.hub.root.member.config;

import org.springframework.context.annotation.Configuration;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Configuration
public class MemberMessageConfig {

	public DefaultMessageService messageService = null;

    public MemberMessageConfig() {
        // 반드시 계정 내 등록된 유효한 API 키, API Secret Key를 입력해주셔야 합니다!
        this.messageService = NurigoApp.INSTANCE.initialize("NCSXFJQDSLMPZION", "XPIBYZQ2FMUJEYGEH1UQEX3UES3L9GOO", "https://api.coolsms.co.kr");
    }

}
