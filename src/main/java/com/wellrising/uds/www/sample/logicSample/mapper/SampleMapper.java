package com.wellrising.uds.www.sample.logicSample.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
public interface SampleMapper {
	public List selectSampleVo() throws Exception;
	public List selectSampleMap() throws Exception;



}
