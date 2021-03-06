package com.hodanet.yuma.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hodanet.common.dao.AbstractDaoService;
import com.hodanet.common.entity.vo.PageData;
import com.hodanet.yuma.constant.YumaCached;
import com.hodanet.yuma.constant.YumaItemStatus;
import com.hodanet.yuma.entity.po.YumaItem;
import com.hodanet.yuma.entity.po.YumaItemModel;
import com.hodanet.yuma.service.YumaItemModelService;
import com.hodanet.yuma.service.YumaItemService;

/**
 * @anthor lyw
 * @yumaItem 2016-11-11 10:34:32
 */
@Service
public class YumaItemServiceImpl extends AbstractDaoService implements YumaItemService {

	@Autowired
	private YumaItemModelService yumaItemModelService;

	@Override
	public YumaItem getYumaItemById(Integer id) {
		return this.getDao().get(YumaItem.class, id);
	}

	@Override
	public PageData<YumaItem> getYumaItemByPage(PageData<YumaItem> pageData, YumaItem yumaItem) {
		List<Object> params = new ArrayList<Object>();
		StringBuilder sb = new StringBuilder();
		sb.append("from YumaItem o where 1=1");
		if (yumaItem.getName() != null) {
			sb.append(" and o.name like ? ");
			params.add("%" + yumaItem.getName() + "%");
		}
		if (yumaItem.getStatus() != null) {
			sb.append(" and o.status = ? ");
			params.add(yumaItem.getStatus());
		}
		sb.append(" order by convert(o.name,'gbk')");
		PageData<YumaItem> pageData2 = this.getDao().queryHqlPageData(sb.toString(), pageData,
				params.toArray(new Object[params.size()]));

		if (yumaItem.isShowModels() && pageData != null && pageData.getData().size() != 0) {
			List<YumaItem> yumaItemList = pageData.getData();
			for (YumaItem item : yumaItemList) {
				YumaItemModel yumaItemModel = new YumaItemModel();
				yumaItemModel.setYumaItem(item);
				item.setYumaItemModels(yumaItemModelService.getYumaItemModelList(yumaItemModel));
			}
		}
		return pageData2;
	}

	@Override
	public YumaItem saveYumaItem(YumaItem yumaItem) {
		if (yumaItem == null) {
			return null;
		}
		if (yumaItem.getId() == null) {
			this.getDao().save(yumaItem);
		} else {
			YumaItem orginal = getYumaItemById(yumaItem.getId());
			orginal.setName(yumaItem.getName());
			orginal.setStatus(yumaItem.getStatus());
			orginal.setType(yumaItem.getType());
			// TODO
		}
		reloadYumaItemsForSelect();
		return yumaItem;
	}

	@Override
	public void deleteYumaItem(Integer[] ids) {
		this.getDao().delete(YumaItem.class, ids);
		reloadYumaItemsForSelect();
	}

	@Override
	public void updateYumaItemStatus(Integer id, Integer status) {
		String hql = "update YumaItem o set o.status = ? where o.id = ?";
		this.getDao().executeUpdate(hql, status, id);
		reloadYumaItemsForSelect();
	}

	@Override
	public PageData<YumaItem> getYumaItemsForSelect() {
		if (YumaCached.YUMA_ITEMS != null) {
			return YumaCached.YUMA_ITEMS;
		}
		reloadYumaItemsForSelect();
		return YumaCached.YUMA_ITEMS;
	}

	private void reloadYumaItemsForSelect() {
		YumaItem yumaItem = new YumaItem();
		yumaItem.setStatus(YumaItemStatus.AVAILABLE.getValue());
		PageData<YumaItem> pageData = new PageData<YumaItem>();
		pageData.setPageSize(Integer.MAX_VALUE);
		YumaCached.YUMA_ITEMS = getYumaItemByPage(pageData, yumaItem);
	}

}
