package com.hub.root.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("board")
public class BoardController {
	@Autowired BoardService bs;

	@GetMapping("list")
	public String board() {
		return "board/list";
	}
}
