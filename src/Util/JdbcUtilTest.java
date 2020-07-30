package Util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class JdbcUtilTest {
    public static void main(String[] args) {
        JdbcUtil jdbcUtil =new JdbcUtil();
        Connection conn = jdbcUtil.getConnection();
        String sql = "select * from traveluser";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            pst = conn.prepareStatement(sql);
            rs = pst.executeQuery();
            // 输出数据库中所有database的名字
            while (rs.next()) { // 迭代器
                System.out.println(rs.getString("UserName"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            jdbcUtil.close(rs, pst, conn);
        }
    }
}
