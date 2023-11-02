package com.wellrising.uds.core.service;

import javax.annotation.Resource;

//public abstract class AbstractService {
public abstract class AbstractService {

	@Resource(name ="default.sqlsession")
	protected DaoSqlSessionTemplate dao;
}
