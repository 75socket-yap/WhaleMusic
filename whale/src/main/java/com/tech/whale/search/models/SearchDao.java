package com.tech.whale.search.models;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.tech.whale.community.dto.PostDto;
import com.tech.whale.setting.dto.UserInfoDto;

@Mapper
public interface SearchDao {
	public List<UserInfoDto> selectSearchUserInfo(String keyword);
	public List<PostDto> selectSearchPostInfo(String keyword);
}
