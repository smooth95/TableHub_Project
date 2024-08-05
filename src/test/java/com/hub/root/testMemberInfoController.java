package com.hub.root;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.forwardedUrl;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.servlet.ModelAndView;

import com.hub.root.member.controller.info.MemberInfoController;
import com.hub.root.member.dto.MemberDTO;

@RunWith(SpringRunner.class)
//@ContextConfiguration(locations = {"classpath:testMember.xml"})
@ContextConfiguration( locations = {"classpath:testMember.xml",
"file:src/main/webapp/WEB-INF/spring/root-context.xml"})

public class testMemberInfoController {
	@Autowired MemberInfoController mic;

	MockMvc mock;

	MockHttpSession session;

	// 다른 테스트 어노테이션값들이 시작되기 전에 실행할 테스트 코드
	@Before
	public void setUp() {
		System.out.println("특정 test들 전에 실행된다.");
		mock = MockMvcBuilders.standaloneSetup(mic).build();
		session = new MockHttpSession();
		session.setAttribute("userId", "aaa");
	}

	// 다른 테슽 어노테이션들이 시작된 후 실행할 테스트 코드
	@After
	public void clean() {
	}

	@Test
	public void testDetail() throws Exception {
		System.out.println("detail Test");

		//url로 요청을 하고 해당 결과를 확인 및 결과값 반환
		MvcResult result = mock.perform(get("/member/myPage/detail")
				.session(session))
				.andExpect(status().isOk())
				.andExpect(forwardedUrl("member/info/detail"))
				.andReturn();

		//반환된 값을 불러와서 객체로 생성
		ModelAndView mav = result.getModelAndView();

		// 생성된 객체가 null이 아니라면 테스트 통과
		assert mav != null;

		// dto에 반환된 값을 대입하고 해당 값이 정상인지 확인
		MemberDTO dto = (MemberDTO) mav.getModel().get("dto");
		System.out.println("dto : " + dto);
		System.out.println("dto.getid : " + dto.getId());
		System.out.println("dto.getid : " + dto.getPwd());

		session.clearAttributes();

	}

}
