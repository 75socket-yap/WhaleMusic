<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script>
    function showReportForm() {
        document.getElementById("reportStatusForm").style.display = "block";
    }

    function reportClose() {
        document.getElementById("reportStatusForm").style.display = "none";
    }

    function reportSubmit() {
        if (confirm("제출하시겠습니까?")) {
            document.getElementById("reportStatusForm").submit();
        }
    }

    window.onload = function() {
        document.getElementById("reportStatusForm").style.display = "none";
    };
</script>

<div class="content" name="content" id="content">
	
	<h1>신고상세</h1>
	<table class="contentTable">
        <colgroup>
            <col width="15%" />
            <col width="35%" />
            <col width="15%" />
            <col width="35%" />
        </colgroup>
        <tbody>
            <tr>
                <th>신고일</th>
                <td><fmt:formatDate value="${reportContent.report_date }" pattern="yyyy.MM.dd  hh:mm" /></td>
                <th>처리일</th>
                <c:if test="${reportContent.report_result_date != null}">
                <td><fmt:formatDate value="${reportContent.report_result_date }" pattern="yyyy.MM.dd  hh:mm" /></td>
            	</c:if>
            	<c:if test="${reportContent.report_result_date == null}">
            	<td>(내용없음)</td>
            	</c:if>
            </tr>
            <tr>
                <th>중복신고</th>
                <c:if test="${reportContent.same_content_count != 0}">
                <td>${reportContent.same_content_count } 건</td>
                </c:if>
                <c:if test="${reportContent.same_content_count == 0}">
                <td>(내용없음)</td>
                </c:if>
                <th>처리자</th>
                <c:if test="${reportContent.admin_id != 0}">
                <td>${reportContent.admin_id }</td>
                </c:if>
                <c:if test="${reportContent.admin_id == 0}">
                <td>(내용없음)</td>
                </c:if>
            </tr>
            <tr>
                <th>신고내용</th>
                <td colspan="3"  style="text-align: left;">${reportContent.report_why }</td>
            </tr>
            <tr>
                <th>처리내용</th>
                <c:if test="${reportContent.report_result_action != null }">
                <td colspan="3"  style="text-align: left;">${reportContent.report_result_action }</td>
                </c:if>
                <c:if test="${reportContent.report_result_action == null }">
                <td>(내용없음)</td>
                </c:if>
            </tr>
            <tr>
                <th>처리사유</th>
                <c:if test="${reportContent.report_result_reason != null}">
                <td colspan="3"  style="text-align: left;">${reportContent.report_result_reason }</td>
                </c:if>
                <c:if test="${reportContent.report_result_reason == null}">
                <td colspan="3" >(내용없음)</td>
                </c:if>
            </tr>
            <tr>
                <th>신고글</th>
                <td colspan="3"  style="text-align: left;">${reportContent.report_text }</td>
            </tr>
			<tr>
			    <th>이미지</th>
			    <td colspan="3">
			    	<img src="/whale/static/images/${imgPath}/${reportContent.report_img_url}" alt="Post Image" style="max-width: 600px; height:90%;">
			    </td>
			</tr>
        </tbody>
        <tr style="border-bottom: none;">
        	<td colspan="4">
        		<input type="button" value="처리하기" onclick="showReportForm()" />
        		<input type="button" value="목록" onclick="adminReportListView?page=${ulsearchVO.page}&sk=${searchKeyword}&searchType=${searchType }" />
        	</td>
        </tr>
    </table>
    <br /><br />
    <form id="reportStatusForm" action="adminReportSubmit" method="post">
       	<table>
       		<tr>
       			<td>작성자</td>
       			<td>
       				<label>
       					<input type="radio" name="userStatus" value="0" onclick="toggleStatusButton()" checked />
       					없음
       				</label>
       				&nbsp;&nbsp;
       				<label>
       					<input type="radio" name="userStatus" value="1" onclick="toggleStatusButton()"/>
       					1일정지
       				</label>
       				<label>
       					<input type="radio" name="userStatus" value="2" onclick="toggleStatusButton()"/>
       					영구정지
       				</label>
       			</td>
       		</tr>
       		<tr>
       			<td>신고글</td>
       			<td>
       				<label>
       					<input type="radio" name="writingStatus" value="0" onclick="toggleStatusButton()" checked/>
       					없음
       				</label>
       				&nbsp;&nbsp;
       				<label>
       					<input type="radio" name="writingStatus" value="1" onclick="toggleStatusButton()"/>
       					삭제
       				</label>
       			</td>
       		</tr>
       		<tr>
       			<td>변경사유</td>
       			<td>
       				<textarea name="statusReason" id="statusReason" cols="60" rows="20"></textarea>
       			</td>
       		</tr>
       		<tr style="border-bottom: none;">
       			<td colspan="2" style="margin: 0 auto;">
       				<input type="hidden" name="userId" value="${AccountUserInfo.user_id }" />
       				<input type="hidden" name="report_id" value="${reportContent.report_id }" />
       				<input type="hidden" name="writingId" value="${writingId }" />
       				<input type="hidden" name="writingType" value="${writingType }" />
       				<input type="hidden" name="page" value="${page }" />
       				<input type="hidden" name="sk" value="${sk }" />
       				<input type="hidden" name="searchType" value="${searchType }" />
       				<button type="button" onclick="reportSubmit()">저장</button>
           			<button type="button" onclick="reportClose()">취소</button>
       			</td>
       		</tr>
       	</table>
    </form>
    <br /><br />
	<h1>유저상세</h1>
	<table class="userInfo">
		<tr>
			<td rowspan="9" class="proImg" style="">
				<div>
					<c:if test="${not empty AccountUserInfo.user_image_url }">
						<img src="/whale/static/images/setting/${AccountUserInfo.user_image_url }" alt="프사" />
					</c:if>
					<c:if test="${empty AccountUserInfo.user_image_url }">
						null
					</c:if>
				</div>
			</td>
			<td>아이디</td>
			<td>${AccountUserInfo.user_id }</td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td>${AccountUserInfo.user_nickname }</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td>${AccountUserInfo.user_email }</td>
		</tr>
		<tr>
			<td>가입일</td>
			<td><fmt:formatDate value="${AccountUserInfo.user_date}" pattern="yyyy.MM.dd" /></td>
		</tr>
		<tr>
			<td>등급</td>
			<td>${AccountUserInfo.user_access_str }</td>
		</tr>
		<tr>
			<td>계정상태</td>
			<td>${AccountUserInfo.user_status_str }</td>
		</tr>
		<tr>
			<td>게시글</td>
			<td>${AccountUserInfo.post_count }</td>
		</tr>
		<tr>
			<td>피드</td>
			<td>${AccountUserInfo.feed_count }</td>
		</tr>
		<tr>
			<td>댓글</td>
			<td>${AccountUserInfo.comments_count }</td>
		</tr>
	</table>
	<br /><br />
</div>