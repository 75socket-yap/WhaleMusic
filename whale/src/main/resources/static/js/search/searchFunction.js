// [ Resize ]
$(document).ready(() => {
    resize();
});
$(window).resize(() => {
    resize();
});

function resize() {
    const headerElement = document.querySelector(".headerSearch");
    const mainElement = document.querySelector(".mainSearch");

    const windowHeight = window.innerHeight;
    const headerHeight = headerElement ? headerElement.offsetHeight : 0;

    if (mainElement) {
        mainElement.style.height = `${windowHeight - headerHeight}px`;
    }
}

let currentSearchType = 'user'; // 기본 검색 유형

$(document).ready(() => {
    resize();

    // 검색 입력 변화 감지
    $('#searchInput').on('input', function() {
        let keyword = $(this).val();
        getSearchResults(keyword);
    });

    // 탭 클릭 이벤트 처리
    $('.mainSearchTab p').on('click', function() {
        // 활성 탭 스타일 업데이트
        $('.mainSearchTab p').removeClass('active');
        $(this).addClass('active');

        // 현재 검색 유형 업데이트
        currentSearchType = $(this).data('type');

        // 현재 키워드로 검색 실행
        let keyword = $('#searchInput').val();
        getSearchResults(keyword);
    });
});

function getSearchResults(keyword) {
    if (!keyword) {
        $('.mainSearchResult').empty(); // 키워드가 없으면 결과를 지웁니다.
        return;
    }

    let url;
    if (currentSearchType === 'user') {
        url = '/whale/search/user';
    } else if (currentSearchType === 'post') {
        url = '/whale/search/post';
    } else if (currentSearchType === 'feed') {
        url = '/whale/search/feed';
    }

    $.ajax({
        url: url,
        type: 'GET',
        data: { keyword: keyword },
        dataType: 'json',
        success: function(response) {
            if (response.success) {
                if (currentSearchType === 'user') {
                    displayUserResults(response.userList);
                } else if (currentSearchType === 'post') {
                    displayPostResults(response.postList);
                } else if (currentSearchType === 'feed') {
                    displayFeedResults(response.feedList);
                }
            } else {
                // 오류 처리
                $('.mainSearchResult').html('<p>검색 결과가 없습니다.</p>');
            }
        },
        error: function(xhr, status, error) {
            // AJAX 오류 처리
            $('.mainSearchResult').html('<p>오류가 발생했습니다. 다시 시도해주세요.</p>');
        }
    });
}

function displayUserResults(userList) {
    let resultDiv = $('.mainSearchResult');
    resultDiv.empty();

    if (userList.length === 0) {
        resultDiv.html('<p>검색 결과가 없습니다.</p>');
        return;
    }

    userList.forEach(function(user) {
        let userHtml = `
            <div class="userItem">
                <img src="${user.user_image_url}" alt="${user.user_nickname}" />
                <p>${user.user_nickname}</p>
            </div>`;
        resultDiv.append(userHtml);
    });
}

function displayPostResults(postList) {
    let resultDiv = $('.mainSearchResult');
    resultDiv.empty();

    if (postList.length === 0) {
        resultDiv.html('<p>검색 결과가 없습니다.</p>');
        return;
    }

    postList.forEach(function(post) {
        let postHtml = `
            <div class="postItem">
                <h3>${post.post_title}</h3>
                <p>${post.post_text}</p>
                <span>${post.user_nickname}</span>
            </div>`;
        resultDiv.append(postHtml);
    });
}

function displayFeedResults(feedList) {
    let resultDiv = $('.mainSearchResult');
    resultDiv.empty();

    if (feedList.length === 0) {
        resultDiv.html('<p>검색 결과가 없습니다.</p>');
        return;
    }

    feedList.forEach(function(feed) {
        let feedHtml = `
            <div class="feedItem">
                <p>${feed.feed_text}</p>
                <span>${feed.user_nickname}</span>
            </div>`;
        resultDiv.append(feedHtml);
    });
}
