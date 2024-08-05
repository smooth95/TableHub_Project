package com.hub.root.businessM.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hub.root.businessM.DTO.BookPageDTO;
import com.hub.root.businessM.DTO.ReservationDTO;
import com.hub.root.businessM.service.businMService;

@RestController
@RequestMapping("store")
public class businMAPIController {

	@Autowired
	private final businMService ser;

	public businMAPIController(businMService ser) {
		this.ser = ser;
	}

    // 민석 예약 부분
    @GetMapping("/api/book")
    public List<BookPageDTO> book(
    		@RequestParam int page,
    		@RequestHeader("store_id") String store_id,
    		@RequestHeader("type") String type
    		)
    {
    	List<BookPageDTO> list = ser.book(page, store_id, type);

		return list;
    }
    @GetMapping("/api/totalPage")
    public int totalPage(
    		@RequestHeader("store_id") String store_id,
    		@RequestHeader("type") String type	) {

    	int result = ser.totalPage(store_id, type);

    	return result;
    }
    @GetMapping("/api/reservationInfo")
    public ReservationDTO reservationInfo(
    		@RequestHeader("store_id") String store_id
    		) {
    	ReservationDTO dto = ser.reservationInfo(store_id);

    	return dto;
    }
}
