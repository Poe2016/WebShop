package test;

import java.util.HashMap;

import org.json.JSONObject;

import com.baidu.aip.imageclassify.AipImageClassify;

public class Sample {
    //设置APPID/AK/SK
    public static final String APP_ID = "11683154";
    public static final String API_KEY = "cfOI87u4VEDtpG3QewYYwXIk";
    public static final String SECRET_KEY = "Qs3lRBca7lIFnhQNGzUBxQZzuxGTk0bs";

    public static void Logosample(AipImageClassify client) {
        // 传入可选参数调用接口
        HashMap<String, String> options = new HashMap<String, String>();
        options.put("custom_lib", "false");
        
        
        // 参数为本地路径
        String image = "D:\\jee-neon\\workspace\\WebShop\\src\\test\\4.jpg";
        JSONObject res = client.logoSearch(image, options);
        System.out.println(res.toString(2));

//        // 参数为二进制数组
//        byte[] file = readFile("test.jpg");
//        res = client.logoSearch(file, options);
//        System.out.println(res.toString(2));
    }
    public static void main(String[] args) {
        // 初始化一个AipImageClassifyClient
        AipImageClassify client = new AipImageClassify(APP_ID, API_KEY, SECRET_KEY);

        // 可选：设置网络连接参数
        client.setConnectionTimeoutInMillis(2000);
        client.setSocketTimeoutInMillis(60000);
        Logosample(client);

        // 可选：设置代理服务器地址, http和socket二选一，或者均不设置
//        client.setHttpProxy("proxy_host", proxy_port);  // 设置http代理
//        client.setSocketProxy("proxy_host", proxy_port);  // 设置socket代理

        // 可选：设置log4j日志输出格式，若不设置，则使用默认配置
        // 也可以直接通过jvm启动参数设置此环境变量
//        System.setProperty("aip.log4j.conf", "path/to/your/log4j.properties");

        // 调用接口
//        String path = "D:\\jee-neon\\workspace\\WebShop\\src\\test\\iphone8.jpg";
//        JSONObject res = client.objectDetect(path, new HashMap<String, String>());
//        System.out.println(res.toString(2));
//        
    }
}