<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>

<div class="content" name="content" id="content">
	<div class="container">
		<h1 id="statistic-name">커뮤니티</h1>
	    <div class="chartBox">
	        <canvas id="reportChart"></canvas>
	    </div>
	    <br />
	    <div class="btnCheck">
	    	<label>
	        	<input type="radio" name="selectStatistic" value="0" onclick="selectPF()" checked/>
	        커뮤
	    	</label>
	    	<label>
	        	<input type="radio" name="selectStatistic" value="1" onclick="selectPF()"/>
	        피드
	    	</label>
	    	<label>
	        	<input type="radio" name="selectStatistic" value="2" onclick="selectPF()"/>
	        커뮤&피드
	    	</label>
		    <div id="postBtn" class="btnBox">
			    <button id="btnChart1">30일</button>
			    <button id="btnChart2">전체기간</button>
			    <button id="btnChart3">커뮤니티구분</button>
			    <button id="btnChart4">댓글 30일</button>
			    <button id="btnChart5">댓글 전체기간</button>
			    <button id="btnChart6">커뮤니티 활동시간</button>
		    </div>
		    <div id="feedBtn" class="btnBox" style="display: none;">
			    <button id="btnChart7">30일</button>
			    <button id="btnChart8">전체기간</button>
			    <button id="btnChart9">댓글 30일</button>
			    <button id="btnChart10">댓글 전체기간</button>
			    <button id="btnChart11">피드 활동시간</button>
		    </div>
		    <div id="allBtn" class="btnBox" style="display: none;">
			    <button id="btnChart12">커뮤&피드 30일</button>
			    <button id="btnChart13">커뮤&피드 전체기간</button>
		    </div>
	    </div>
	</div>
</div>
<script>
	
	function selectPF(){
		var selectedValue = document.querySelector('input[name="selectStatistic"]:checked').value;
	    if (selectedValue === '0') {
	    	postBtn.style.display = 'block';
	    } else {
	    	postBtn.style.display = 'none';
	    }
	    if (selectedValue === '1') {
	    	feedBtn.style.display = 'block';
	    } else {
	    	feedBtn.style.display = 'none';
	    }
	    if (selectedValue === '2') {
	    	allBtn.style.display = 'block';
	    } else {
	    	allBtn.style.display = 'none';
	    }
		
	}
	
    document.addEventListener("DOMContentLoaded", function () {
    	
    	var cfLabels1 = [];
    	<c:forEach var="label" items="${cfLabels1}">
    	cfLabels1.push('${label}');
    	</c:forEach>
    	var cfValues1 = [];
    	<c:forEach var="value" items="${cfValues1}">
    	cfValues1.push(${value});
    	</c:forEach>
    	
    	
    	var cfLabels2 = [];
    	<c:forEach var="label" items="${cfLabels2}">
    	cfLabels2.push('${label}');
    	</c:forEach>
    	var cfValues2 = [];
    	<c:forEach var="value" items="${cfValues2}">
    	cfValues2.push(${value});
    	</c:forEach>
    	
    	
    	var cfLabels3 = [];
    	<c:forEach var="label" items="${cfLabels3}">
    	cfLabels3.push('${label}');
    	</c:forEach>
    	var cfValues3 = [];
    	<c:forEach var="value" items="${cfValues3}">
    	cfValues3.push(${value});
    	</c:forEach>  
    	
    	
    	var backColors1 = [];
    	<c:forEach var="color" items="${backColors1}">
    	    backColors1.push('${color}');
    	</c:forEach>;
    	var backColors2 = [];
    	<c:forEach var="color" items="${backColors2}">
    	    backColors2.push('${color}');
    	</c:forEach>;
    	var backColors3 = [];
    	<c:forEach var="color" items="${backColors3}">
    	    backColors3.push('${color}');
    	</c:forEach>;
        
    	
    	    const chartConfigurations = [
    	        { btnId: 'btnChart1', type: 'bar', labels: cfLabels1, values: cfValues1, label: '커뮤작성글', chartFunc: updateChart1, title: "커뮤니티 작성글 통계" },
    	        { btnId: 'btnChart2', type: 'line', labels: cfLabels2, values: cfValues2, label: '커뮤작성글', chartFunc: updateChart1, title: "커뮤니티 작성글 통계" },
    	        { btnId: 'btnChart3', type: 'pie', labels: cfLabels3, values: cfValues3, label: '커뮤구분', chartFunc: updateChart2, backColors: backColors1, title: "커뮤니티 구분 통계" }
    	       
    	    ];

    	    chartConfigurations.forEach(config => {
    	        document.getElementById(config.btnId).addEventListener('click', function () {
    	            if (config.chartFunc === updateChart2) {
    	                config.chartFunc(config.type, config.labels, config.values, config.label, config.backColors);
    	            } else {
    	                config.chartFunc(config.type, config.labels, config.values, config.label);
    	            }
    	            document.getElementById('statistic-name').innerText = config.title; // 설정된 제목으로 텍스트 변경
    	        });
    	    });
    	
    	
        const ctx = document.getElementById('reportChart').getContext('2d');
        let chartData = {
                labels: cfLabels1,
                datasets: [{
                    label: '',
                    data: cfValues1,
                    backgroundColor: 'rgba(162, 162, 235, 0.5)'
                }]
            };

            // 차트 생성
            let myChart = new Chart(ctx, {
                type: 'bar',
                data: chartData,
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
    		            x: {
    		                grid: {
    		                    display: false
    		                }
    		            },
    		            y: {
    		                grid: {
    		                    display: true
    		                }
    		            }
    		        }
                }
            });
            
            function updateChart1(type, labels, data, label) {
                myChart.destroy(); // 기존 차트 삭제
                myChart = new Chart(ctx, {
                    type: type,
                    data: {
                        labels: labels,
                        datasets: [{
                            label: label,
                            data: data,
                            backgroundColor: 'rgba(162, 162, 235, 0.5)',
                            /* borderColor: getBorderColors(data.length), */
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
        		            x: {
        		                grid: {
        		                    display: false
        		                }
        		            },
        		            y: {
        		                grid: {
        		                    display: true
        		                }
        		            }
        		        }
                    }
                });
            }
            function updateChart2(type, labels, data, label,backColors) {
                myChart.destroy(); // 기존 차트 삭제
                myChart = new Chart(ctx, {
                    type: type,
                    data: {
                        labels: labels,
                        datasets: [{
                            data: data,
                            backgroundColor: backColors,
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: true,
                                position: 'left' // 범례를 왼쪽에 위치
                            }
                        }
                    }
                });
            }
            

        });
</script>
