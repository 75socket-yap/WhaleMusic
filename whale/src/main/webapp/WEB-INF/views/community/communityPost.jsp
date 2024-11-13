<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Community Board</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;600&display=swap">
<script src="static/js/setting/darkMode.js"></script>
<style>
    .content-wrapper[data-darkmode="0"] body {font-family: 'Noto Sans', sans-serif; margin: 0; padding: 0; color: #333333; background-color: #f8f9fa;}
    .content-wrapper[data-darkmode="0"] h2 {font-size: 24px; font-weight: bold; color: #444; text-align: center; margin-bottom: 20px;}
    .content-wrapper[data-darkmode="0"] h2 a {color: #333333; text-decoration: none;}
    .content-wrapper[data-darkmode="0"] .content-wrapper {max-width: 1200px; margin: auto; padding: 20px; background-color: #ffffff;}
    .content-wrapper[data-darkmode="0"] .table-container {margin-top: 10px;}
    .content-wrapper[data-darkmode="0"] table {width: 100%; border-collapse: collapse;}
    .content-wrapper[data-darkmode="0"] th, td {padding: 10px; border-bottom: 1px solid #e9ecef; text-align: left;}
    .content-wrapper[data-darkmode="0"] th {background-color: #f1f3f5; font-weight: 700; color: #495057;}
    .content-wrapper[data-darkmode="0"] td {color: #495057;}
    .content-wrapper[data-darkmode="0"] tr:hover td {background-color: #f8f9fa;}
    .content-wrapper[data-darkmode="0"] .fixed {color: #f03e3e; font-weight: bold;}
    .content-wrapper[data-darkmode="0"] .notice-icon, .post-stats {color: #adb5bd; font-size: 0.9em;}
    .content-wrapper[data-darkmode="0"] td a {color: black; text-decoration: none;}
    .content-wrapper[data-darkmode="0"] td a:hover {text-decoration: underline;}
    .content-wrapper[data-darkmode="0"] .pagination {display: flex; justify-content: center; margin-top: 20px;}
    .content-wrapper[data-darkmode="0"] .pagination a, .pagination span {padding: 8px 12px; margin: 0 4px; background-color: #ffffff; border: 1px solid #dee2e6; border-radius: 4px; color: #495057; text-decoration: none; font-weight: 500;}
    .content-wrapper[data-darkmode="0"] .pagination a:hover {background-color: #e9ecef;}
    .content-wrapper[data-darkmode="0"] .pagination .disabled {color: #adb5bd; pointer-events: none;}
    .content-wrapper[data-darkmode="0"] .footer {text-align: center; margin-top: 20px; font-size: 12px; color: #868e96;}
    #userModal[data-darkmode="0"]{display: none; position: fixed; z-index: 1; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.6);}
    #userModal[data-darkmode="0"] .modal-content {background-color: #ffffff; margin: 15% auto; padding: 20px; border-radius: 8px; width: 300px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);}
    #userModal[data-darkmode="0"] .close {color: #aaa; float: right; font-size: 28px; font-weight: bold; cursor: pointer;}
    #userModal[data-darkmode="0"] .close:hover, .close:focus {color: #333; text-decoration: none; cursor: pointer;}
    #userModal[data-darkmode="0"] .modal-links a {display: block; padding: 10px; margin-top: 10px; text-align: center; background-color: #1a73e8; color: white; border-radius: 5px; text-decoration: none; font-weight: bold;}
    #userModal[data-darkmode="0"] .modal-links a:hover {background-color: #1666c1;}
    #userModal[data-darkmode="0"] .user-id {font-weight: bold; cursor: pointer;}
    #userModal[data-darkmode="0"] .user-id:hover {color: #1666c1;}
    #userModal[data-darkmode="0"] .pagination .current {font-weight: bold; color: #1a73e8;}
    /* ------------------------------------------------------------------------------------------------ */
    .content-wrapper[data-darkmode="1"] body {font-family: 'Noto Sans', sans-serif; margin: 0; padding: 0; color: whitesmoke; background-color: #1f1f1f;}
    .content-wrapper[data-darkmode="1"] h2 {font-size: 24px; font-weight: bold; color: whitesmoke; text-align: center; margin-bottom: 20px;}
    .content-wrapper[data-darkmode="1"] h2 a {color: whitesmoke; text-decoration: none;}
    .content-wrapper[data-darkmode="1"] h2 a:visited {color: whitesmoke; text-decoration: none;}
    .content-wrapper[data-darkmode="1"] .content-wrapper {max-width: 1200px; margin: auto; padding: 20px; background-color: #1f1f1f;}
    .content-wrapper[data-darkmode="1"] .table-container {margin-top: 10px;}
    .content-wrapper[data-darkmode="1"] table {width: 100%; border-collapse: collapse;}
    .content-wrapper[data-darkmode="1"] th, td {padding: 10px; border-bottom: 1px solid whitesmoke; text-align: left;}
    .content-wrapper[data-darkmode="1"] th {background-color: #1f1f1f; font-weight: 700; color: whitesmoke;}
    .content-wrapper[data-darkmode="1"] td {color: whitesmoke;}
    .content-wrapper[data-darkmode="1"] tr:hover td {background-color: #1f1f1f;}
    .content-wrapper[data-darkmode="1"] .fixed {color: #f03e3e; font-weight: bold;}
    .content-wrapper[data-darkmode="1"] .notice-icon, .post-stats {color: #adb5bd; font-size: 0.9em;}
    .content-wrapper[data-darkmode="1"] td a {color: whitesmoke; text-decoration: none;}
    .content-wrapper[data-darkmode="1"] td a:hover {text-decoration: underline;}
    .content-wrapper[data-darkmode="1"] .pagination {display: flex; justify-content: center; margin-top: 20px;}
    .content-wrapper[data-darkmode="1"] .pagination a, .pagination span {padding: 8px 12px; margin: 0 4px; background-color: #1f1f1f; border: 1px solid #dee2e6; border-radius: 4px; color: whitesmoke; text-decoration: none; font-weight: 500;}
    .content-wrapper[data-darkmode="1"] .pagination a:hover {background-color: lightgray;}
    .content-wrapper[data-darkmode="1"] .pagination .disabled {color: #adb5bd; pointer-events: none;}
    .content-wrapper[data-darkmode="1"] .footer {text-align: center; margin-top: 20px; font-size: 12px; color: whitesmoke;}
    #userModal[data-darkmode="1"]{display: none; position: fixed; z-index: 1; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.6);}
    #userModal[data-darkmode="1"] .modal-content {background-color: #2e2e2e; margin: 15% auto; padding: 20px; border-radius: 8px; width: 300px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);}
    #userModal[data-darkmode="1"] .modal-header {color: whitesmoke;}
    #userModal[data-darkmode="1"] .close {color: #aaa; float: right; font-size: 28px; font-weight: bold; cursor: pointer;}
    #userModal[data-darkmode="1"] .close:hover, .close:focus {color: whitesmoke; text-decoration: none; cursor: pointer;}
    #userModal[data-darkmode="1"] .modal-links a {display: block; padding: 10px; margin-top: 10px; text-align: center; background-color: #335580; color: white; border-radius: 5px; text-decoration: none; font-weight: bold;}
    #userModal[data-darkmode="1"] .modal-links a:hover {background-color: #335580;}
    #userModal[data-darkmode="1"] .user-id {font-weight: bold; cursor: pointer;}
    #userModal[data-darkmode="1"] .user-id:hover {color: #335580;}
    #userModal[data-darkmode="1"] .pagination .current {font-weight: bold; color: #335580;}

	.content-wrapper[data-darkmode="1"] .announcement {
	    background-color: #474747; /* 연한 회색 배경 */
	    font-weight: bold; /* 글씨를 굵게 */
	}
	
	
	.content-wrapper[data-darkmode="0"] .announcement {
	    background-color: #f2f2f2; /* 연한 회색 배경 */
	    font-weight: bold; /* 글씨를 굵게 */
	}

    .search-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: #2e2e2e;
        margin: 20px 0;
        padding: 10px 40px;
        border-radius: 10px;
        margin-top: 15px;
    }

    .search-bar input[type="text"] {
        width: 30%;
        padding: 10px;
        border: 1px solid #D0D0D0;
        border-radius: 8px;
        background-color: #FFFFFF;
        color: #000000;
        font-family: 'Noto Sans', sans-serif;
        font-weight: 400;
    }

    .search-bar input[type="submit"] {
        padding: 10px 20px;
        background-color: #000000;
        border: none;
        color: #FFFFFF;
        cursor: pointer;
        border-radius: 8px;
        transition: background-color 0.3s;
        font-family: 'Noto Sans', sans-serif;
        font-weight: 600;
    }

    .search-bar input[type="submit"]:hover {
        background-color: #333333;
    }


</style>
</head>
<body>

<div class="content-wrapper" data-darkmode="${darkMode.scndAttrName}">
    <h2><a href="communityPost?c=${param.c}" class="community-link">${communityName}</a></h2>

    <div class="table-container">
        <table>
            <tr>
                <th>번호</th>
                <th>태그</th>
                <th>제목</th>
                <th>작성자</th>
                <th>등록일</th>
                <th>조회수</th>
                <th>좋아요</th>
            </tr>
            <c:forEach items="${list}" var="p">
                <tr 
	                <c:if test="${p.post_tag_text == '[공지]'}">
	                    class="announcement"
	                </c:if>
            	>
                    <td>${p.post_num}</td>
                    <td>${p.post_tag_text}</td>
                    <td><a href="communityDetail?c=${param.c}&p=${p.post_id}">${p.post_title} 
                    	<c:if test="${p.commentsCount != 0}">
                    	(${p.commentsCount})
                    	</c:if>
                    	</a></td>
                    <td>
					    <span class="user-id" 
					          data-user-id="${p.user_id}" 
					          data-user-nickname="${p.user_nickname}" 
					          data-user-image-url="${p.user_image_url}" 
					          onclick="openModal(this)">
					        ${p.user_id}
					    </span>
					</td>
                    <td>${p.post_date}</td>
                    <td>${p.post_cnt}</td>
                    <td>${p.likeCount}</td> <!-- 좋아요 수 추가 -->
                </tr>
            </c:forEach>
        </table>
    </div>

    <div style="text-align: right; margin-top: 20px;">
        <a href="communityReg?c=${param.c}" class="btn" style="background-color: #335580; color: #ffffff; padding: 10px 20px; border-radius: 4px; text-decoration: none; font-weight: bold;">글 작성</a>
    </div>

    <div class="pagination">
        <c:choose>
            <c:when test="${searchVO.page > 1}">
                <a href="communityPost?c=${param.c}&page=${searchVO.page - 1}">이전</a>
            </c:when>
            <c:otherwise>
                <span class="disabled">이전</span>
            </c:otherwise>
        </c:choose>
	    <c:forEach var="i" begin="1" end="${searchVO.totPage}">
	        <c:choose>
	            <c:when test="${i == searchVO.page}">
	                <span class="current">${i}</span>
	            </c:when>
	            <c:otherwise>
	                <a href="communityPost?c=${param.c}&page=${i}">${i}</a>
	            </c:otherwise>
	        </c:choose>
	    </c:forEach>
        <c:choose>
            <c:when test="${searchVO.page < searchVO.totPage}">
                <a href="communityPost?c=${param.c}&page=${searchVO.page + 1}">다음</a>
            </c:when>
            <c:otherwise>
                <span class="disabled">다음</span>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="footer">
        &copy; Whale Community
    </div>
</div>

<div id="userModal" class="modal" style="display: none;" data-darkmode="${darkMode.scndAttrName}">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <div class="modal-header">
            <img id="modal-user-image" src="" alt="User Image" style="width: 80px; height: 80px; border-radius: 50%; margin-right: 15px;">
            <div class="modal-info">
                <h2 id="modal-user-nickname"></h2>
                <p id="modal-user-id"></p>
            </div>
        </div>
        <div class="modal-links">
            <a href="" id="profile-link" class="modal-link">프로필</a> 
            <a href="" id="message-link" class="modal-link">메시지 보내기</a>
        </div>
    </div>
</div>

<form action="communityPost" class="search-bar">
    <input type="hidden" name="c" value="${param.c}" />
    
        <c:choose>
            <c:when test="${title}">
                <input type="checkbox" name="searchType" value="title" checked /> 제목
            </c:when>
            <c:otherwise>
                <input type="checkbox" name="searchType" value="title" /> 제목
            </c:otherwise>
        </c:choose>
        <c:choose>
            <c:when test="${content}">
                <input type="checkbox" name="searchType" value="content" checked /> 내용
            </c:when>
            <c:otherwise>
                <input type="checkbox" name="searchType" value="content" /> 내용
            </c:otherwise>
        </c:choose>
        <select name="tagId">
            <option value="">모든 태그</option>
            <c:forEach items="${tlist}" var="t">
                <option value="${t.post_tag_id}" ${param.tagId == t.post_tag_id ? "selected" : "" }>${t.post_tag_text}</option>
            </c:forEach>
        </select>
        <input type="text" name="sk" value="${searchKeyword}" placeholder="검색어를 입력하세요" />
        <input type="submit" value="검색" />
    
</form>

<script>
    // 모달 열기
    function openModal(element) {
        const userId = element.getAttribute("data-user-id");
        const userNickname = element.getAttribute("data-user-nickname");
        const userImageUrl = element.getAttribute("data-user-image-url");

        // 모달에 값 채우기
        document.getElementById("modal-user-id").innerText = "@" + userId;
        document.getElementById("modal-user-nickname").innerText = userNickname;
        document.getElementById("modal-user-image").src = userImageUrl;

        // 링크 설정
        document.getElementById('profile-link').href = "profileHome?u=" + userId;
        document.getElementById('message-link').href = "messageGo?u=" + userId;

        // 모달 열기
        document.getElementById("userModal").style.display = "block";
    }

    // 모달 닫기
    function closeModal() {
        document.getElementById("userModal").style.display = "none";
    }

    // 모달 외부 클릭 시 닫기
    window.onclick = function(event) {
        const modal = document.getElementById("userModal");
        if (event.target == modal) {
            closeModal();
        }
    };
</script>

</body>
</html>