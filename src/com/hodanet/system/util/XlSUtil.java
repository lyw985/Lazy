package com.hodanet.system.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class XlSUtil {
	private static Logger logger = Logger.getLogger("XlSUtil");
	private final static String xls = "xls";
	private final static String xlsx = "xlsx";

	public static Workbook getWorkbook(InputStream is, String fileName) {
		// 创建Workbook工作薄对象，表示整个excel
		Workbook workbook = null;
		try {
			// 根据文件后缀名不同(xls和xlsx)获得不同的Workbook实现类对象
			if (fileName.endsWith(xls)) {
				// 2003
				workbook = new HSSFWorkbook(is);
			} else if (fileName.endsWith(xlsx)) {
				// 2007
				workbook = new XSSFWorkbook(is);
			}
		} catch (IOException e) {
			logger.info(e.getMessage());
		}
		return workbook;
	}

	public static List<String[]> readExcel(InputStream is, String fileName) throws IOException {
		Workbook workbook = getWorkbook(is, fileName);
		return readExcel(workbook);
	}

	public static List<String[]> readExcel(Workbook workbook) throws IOException {
		// 检查文件
//		checkFile(file);
		// 创建返回对象，把每行中的值作为一个数组，所有行作为一个集合返回
		List<String[]> list = new ArrayList<String[]>();
		if (workbook != null) {
			for (int sheetNum = 0; sheetNum < workbook.getNumberOfSheets(); sheetNum++) {
				// 获得当前sheet工作表
				Sheet sheet = workbook.getSheetAt(sheetNum);
				int maxCellSize = 0;
				if (sheet == null) {
					continue;
				}
				// 获得当前sheet的开始行
				int firstRowNum = sheet.getFirstRowNum();
				// 获得当前sheet的结束行
				int lastRowNum = sheet.getLastRowNum();
				for (int rowNum = firstRowNum; rowNum <= lastRowNum; rowNum++) {
					// 获得当前行
					Row row = sheet.getRow(rowNum);
					if (row == null) {
						continue;
					}
					// 获得当前行的开始列
					int firstCellNum = row.getFirstCellNum();
					// 获得当前行的列数
					int lastCellNum = row.getPhysicalNumberOfCells();
					maxCellSize = lastCellNum > maxCellSize ? lastCellNum : maxCellSize;
					String[] cells = new String[maxCellSize];
					// 循环当前行
					for (int cellNum = firstCellNum; cellNum < maxCellSize; cellNum++) {
						Cell cell = row.getCell(cellNum);
						cells[cellNum] = getCellValue(cell);
					}
					list.add(cells);
				}
			}
			workbook.close();
		}
		return list;
	}

	public static String getCellValue(Cell cell) {
		String cellValue = "";
		if (cell == null) {
			return cellValue;
		}
		// 把数字当成String来读，避免出现1读成1.0的情况
		if (cell.getCellType() == CellType.NUMERIC) {
			cell.setCellType(CellType.STRING);
		}

		// 判断数据的类型
		switch (cell.getCellType()) {
		case NUMERIC: // 数字
			cellValue = String.valueOf(cell.getNumericCellValue());
			break;
		case STRING: // 字符串
			cellValue = String.valueOf(cell.getStringCellValue());
			break;
		case BLANK: // 空值
			cellValue = "";
			break;
		default:
			cellValue = "未知类型";
			break;
		}
		return cellValue;
	}
}
