<table_hub>
  
=== KG IT 뱅크 2조 프로젝트(캐치테이블) ===


- com.hub.root.자신폴더 : 기본파일로 class로 만든것 무시
- com.hub.root.자신폴더.mybatis : 안의 interface는 파일 그대로 사용

- web.xml : filter주석처리한것 필요시 사용(및 추가)

- servlet-context.xml : interceptor, bean필요시 각자 추가

- pom.xml : 필요시 각자 의존성 추가

- src/main/resources - mappers- 각자 폴더이름 : 각자폴더Mapper.xml 그대로 사용

- src - main - webapp- resources : 안의 css, img, js사용시 폴더안에 각자폴더 만들어서 사용(기본 hub.css, hub.xml, hub.js무시)

- views - 각자폴더 - 폴더이름.jsp : jsp파일 무시
