package com.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.util.Conn2Ora;
import com.util.Good;

/**
 * Servlet implementation class UploadServlet
 */
@WebServlet("/UploadServlet")
public class UpLoadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// 上传文件存储目录
	private static final String UPLOAD_DIRECTORY = "home\\goodsimgs";

	// 上传配置
	private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3; // 3MB
	private static final int MAX_FILE_SIZE = 1024 * 1024 * 40; // 40MB
	private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 50; // 50MB

	/**
	 * 上传数据及保存文件
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("GBK");
		HttpSession session = request.getSession();
		Conn2Ora conn2 = Conn2Ora.getInstance();
		Connection con = conn2.con;
		// 获取存储商品的容器
		ArrayList<Good> list = com.servlet.WelcomeServlet.getList(con);
		String goodNo = String.format("%08d", (list.size() + 1));// 获取商品编号
		System.out.println("编号：" + goodNo);
		String goodName = null;// 商品名
		Integer goodPrice = null;// 商品价格
		String goodUserSale = (String) session.getAttribute("onlineuser");// 商品上传者
		String goodDescription = null;// 商品描述
		Integer goodNum = null;// 商品数量，-指某个用户上传的某一个商品的数量
		String goodfilename = null;// 上传到服务器上的图片的文件名，不包括编号
		String type = null;// 商品的类型
		String detial_type = null;//详细类型
		// 检测是否为多媒体上传
		if (!ServletFileUpload.isMultipartContent(request)) {
			// 如果不是则停止
			PrintWriter writer = response.getWriter();
			writer.println("Error: 表单必须包含 enctype=multipart/form-data");
			writer.flush();
			return;
		}

		// 配置上传参数
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// 设置内存临界值 - 超过后将产生临时文件并存储于临时目录中
		factory.setSizeThreshold(MEMORY_THRESHOLD);
		// 设置临时存储目录
		factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

		ServletFileUpload upload = new ServletFileUpload(factory);

		// 设置最大文件上传值
		upload.setFileSizeMax(MAX_FILE_SIZE);

		// 设置最大请求值 (包含文件和表单数据)
		upload.setSizeMax(MAX_REQUEST_SIZE);

		// 构造临时路径来存储上传的文件
		// 这个路径相对当前应用的目录
		String uploadPath = getServletContext().getRealPath("./") + File.separator + UPLOAD_DIRECTORY;
		// String uploadPath = "G:\\新建文件夹";

		// 如果目录不存在则创建
		File uploadDir = new File(uploadPath);
		if (!uploadDir.exists()) {
			uploadDir.mkdir();
		}

		try {
			// 解析请求的内容提取文件数据
			@SuppressWarnings("unchecked")
			List<FileItem> formItems = upload.parseRequest(request);

			if (formItems != null && formItems.size() > 0) {
				// 迭代表单数据
				for (FileItem item : formItems) {
					// 处理不在表单中的字段
					if (!item.isFormField()) {
						File f = new File(item.getName());
						String fileName = f.getName();
						goodfilename = fileName;
						String filePath = uploadPath + File.separator + goodNo + "+" + fileName;
						File storeFile = new File(filePath);
						// 在控制台输出文件的上传路径
						System.out.println("路径： " + filePath);
						// 保存文件到硬盘
						item.write(storeFile);

					} else {
						String temp = new String(item.getString("UTF-8"));
						String itemfildname = item.getFieldName();
						if (itemfildname.equals("goodname")) {
							goodName = temp;// 商品名
							System.out.println("名字：" + goodName);
						} else if (itemfildname.equals("pro_shortdesc")) {
							goodDescription = temp;
							System.out.println("描述：" + goodDescription);
						} else if (itemfildname.equals("goodprice")) {
							goodPrice = Integer.parseInt(temp);// 商品价格
							System.out.println("价格：" + goodPrice.intValue());
						} else if (itemfildname.equals("goodamount")) {
							goodNum = Integer.parseInt(temp);
							System.out.println("库存：" + goodNum.intValue());
						} else if (itemfildname.equals("goodtype")) {
							type = temp;
							System.out.println("类型：" + type);
						} else if (itemfildname.equals("detailid")) {
							detial_type = temp;
							System.out.println("详细类型：" + detial_type);
						}

					}
				}
				Good g = new Good(goodNo, goodName, goodPrice, goodUserSale, goodDescription, goodNum, goodfilename,
						type,detial_type);
				list.add(g);
				com.servlet.WelcomeServlet.updateGoodList(con, list);// 更新list
				request.setAttribute("message", "文件上传成功!");
			}
		} catch (Exception ex) {
			request.setAttribute("message", "错误信息: " + ex.getMessage());
		}
		// 跳转到 message.jsp
		getServletContext().getRequestDispatcher("/home/message.jsp").forward(request, response);
	}
}
