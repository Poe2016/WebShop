package com.util;
/**
 * 计算两个字符串的相似度
 * @author Poe
 *
 */
public class Similarity {
	private int compare(String str, String target)
    {
        int d[][];              // 矩阵
        int n = str.length();
        int m = target.length();
        int i;                  // 遍历str的
        int j;                  // 遍历target的
        char ch1;               // str的
        char ch2;               // target的
        int temp;               // 记录相同字符,在某个矩阵位置值的增量,不是0就是1
        if (n == 0) { return m; }
        if (m == 0) { return n; }
        d = new int[n + 1][m + 1];
        for (i = 0; i <= n; i++)
        {                       // 初始化第一列
            d[i][0] = i;
        }

        for (j = 0; j <= m; j++)
        {                       // 初始化第一行
            d[0][j] = j;
        }

        for (i = 1; i <= n; i++)
        {                       // 遍历str
            ch1 = str.charAt(i - 1);
            // 去匹配target
            for (j = 1; j <= m; j++)
            {
                ch2 = target.charAt(j - 1);
                if (ch1 == ch2 || ch1 == ch2+32 || ch1+32 == ch2)
                {
                    temp = 0;
                } else
                {
                    temp = 1;
                }
                // 左边+1,上边+1, 左上角+temp取最小
                d[i][j] = min(d[i - 1][j] + 1, d[i][j - 1] + 1, d[i - 1][j - 1] + temp);
            }
        }
        return d[n][m];
    }

    private int min(int one, int two, int three)
    {
        return (one = one < two ? one : two) < three ? one : three;
    }

    /**
     * 获取两字符串的相似度
     */

    public float getSimilarityRatio(String str, String target)
    {
        return 1 - (float) compare(str, target) / Math.max(str.length(), target.length());
    }
    
    /**
	 * 计算两个字符串之间的相似度，该算法按照
	 * @param info表示商品的名字或者商品的描述
	 * @param key搜素的关键字
	 * @return返回一个介于0~1之间的小数，表示相似度
	 */
	private float similarity_info_key(String info,String key){
		float similarity=0;
		similarity=getSimilarityRatio(info, key);
		return similarity;
	}
	/**
	 * 计算商品和关键字之间的相似度，该算法按商品名的相似度*0.5+商品描述的像素度*0.5计算
	 * @param g表示商品
	 * @param key表示所搜的关键字
	 * @return返回相似度，为一个介于0~1之间的小数
	 */
	public float similarity_g_key(Good g,String key){
		float similarity=0;
		similarity=(similarity_info_key(g.getGoodName(),key)+similarity_info_key(g.getGoodDescription(),key))/2;
		return similarity;
	}

}
