package com.wellrising.uds.util.file.service;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.wellrising.uds.core.service.AbstractService;

/**
 * @Class Name : WRFileMngServiceImpl.java
 * @Description : 파일정보의 관리를 위한 구현 클래스
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 3. 25.     이삼섭    최초생성
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 25.
 * @version
 * @see
 *
 */
@Service
public class WRFileMngService extends AbstractService {


	/**
	 * 여러 개의 파일을 삭제한다.
	 */
	public void deleteFileInfs(List<?> fvoList) throws Exception {
		Iterator<?> iter = fvoList.iterator();
		WRFileVO vo;
		while (iter.hasNext()) {
			vo = (WRFileVO) iter.next();

			WRFileVO tmpVo = dao.selectOne("wRFileMng.selectFileInf", vo);
			dao.delete("wRFileMng.deleteFileDetail", vo);
			WRFileDeleteUtil.deleteFile(tmpVo);
		}
	}

	/**
	 * 하나의 파일에 대한 정보(속성 및 상세)를 등록한다.
	 */
	public String insertFileInf(WRFileVO fvo) throws Exception {
		String atchFileId = fvo.getAtchFileId();

		dao.insert("wRFileMng.insertFileMaster", fvo);
		dao.insert("wRFileMng.insertFileDetail", fvo);

		return atchFileId;
	}

	/**
	 * 여러 개의 파일에 대한 정보(속성 및 상세)를 등록한다.
	 */
	public String insertFileInfs(List<?> fvoList) throws Exception {
		WRFileVO vo = (WRFileVO) fvoList.get(0);
		String atchFileId = vo.getAtchFileId();

		if (fvoList.size() != 0) {
			dao.insert("wRFileMng.insertFileMaster", vo);

			Iterator<?> iter = fvoList.iterator();
			while (iter.hasNext()) {
				vo = (WRFileVO) iter.next();
				dao.insert("wRFileMng.insertFileDetail", vo);
			}
		}
		if (atchFileId == "") {
			atchFileId = null;
		}
		return atchFileId;
	}

	/**
	 * 파일에 대한 목록을 조회한다.
	 */
	public List<WRFileVO> selectFileInfs(WRFileVO fvo) throws Exception {
		return dao.selectList("wRFileMng.selectFileList", fvo);
	}

	/**
	 * 여러 개의 파일에 대한 정보(속성 및 상세)를 수정한다.
	 */
	public void updateFileInfs(List<?> fvoList) throws Exception {
		//Delete & Insert
		WRFileVO vo;
		Iterator<?> iter = fvoList.iterator();
		while (iter.hasNext()) {
			vo = (WRFileVO) iter.next();
			dao.insert("wRFileMng.insertFileDetail", vo);
		}
	}

	/**
	 * 하나의 파일을 삭제한다.
	 */
	public void deleteFileInf(WRFileVO fvo) throws Exception {
		WRFileVO tmpVo = dao.selectOne("wRFileMng.selectFileInf", fvo);
		dao.delete("wRFileMng.deleteFileDetail", fvo);
		WRFileDeleteUtil.deleteFile(tmpVo);
	}

	/**
	 * 파일에 대한 상세정보를 조회한다.
	 */
	public WRFileVO selectFileInf(WRFileVO fvo) throws Exception {
		return dao.selectOne("wRFileMng.selectFileInf", fvo);
	}

	/**
	 * 파일 구분자에 대한 최대값을 구한다.
	 */
	public int getMaxFileSN(WRFileVO fvo) throws Exception {
		return dao.selectOne("wRFileMng.selectFileInf", fvo);
	}

	/**
	 * 전체 파일을 삭제한다.
	 */
	public void deleteAllFileInf(WRFileVO fvo) throws Exception {
		dao.update("wRFileMng.deleteCOMTNFILE", fvo);
	}

	/**
	 * 파일명 검색에 대한 목록을 조회한다.
	 */
	public Map<String, Object> selectFileListByFileNm(WRFileVO fvo) throws Exception {
		List<WRFileVO> result = dao.selectList("wRFileMng.selectFileListByFileNm", fvo);
		int cnt = dao.selectOne("wRFileMng.selectFileListCntByFileNm", fvo);

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));

		return map;
	}

	/**
	 * 이미지 파일에 대한 목록을 조회한다.
	 */
	public List<WRFileVO> selectImageFileList(WRFileVO vo) throws Exception {
		return dao.selectList("wRFileMng.selectImageFileList", vo);
	}
}
