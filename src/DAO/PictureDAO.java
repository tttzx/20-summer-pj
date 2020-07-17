package DAO;

import Entity.Picture;
import Entity.User;
import Util.JdbcUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PictureDAO {

    private static  JdbcUtil jdbcUtil=new JdbcUtil();

    public static Picture findPic(String ID) {
        Picture picture = null;
        Connection conn = jdbcUtil.getConnection();
        String sql = "SELECT * from travelimage WHERE ImageID = '" + ID + "'";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            pst = conn.prepareStatement(sql);
            rs = pst.executeQuery();
            if (rs.next()) {
                User user = UserDAO.findUserByID(rs.getString("uid"));
                String countryName = RegionDAO.getCountryName(rs.getString("country_RegionCodeIso"));
                String cityName = RegionDAO.getCityName(rs.getString("cityCode"));
                picture = new Picture(rs.getString("ImageID"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        cityName,
                        countryName,
                        user.getUserName(),
                        rs.getString("path"),
                        rs.getString("content"),
                        rs.getInt("likeperson"));
            }
            return picture;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            jdbcUtil.close(rs, pst, conn);
        }

    }


    public static List<Picture> getHotPic() {
        String sql = "SELECT ImageID, COUNT(*) AS count FROM travelimagefavor GROUP BY ImageID " +
                "ORDER BY count DESC LIMIT 4";
        return getPicList(sql);
    }

    public static List<Picture> getNewPic(){
        String sql = "SELECT * from travelimage ORDER BY ImageID DESC LIMIT 4";
        return getPicList(sql);
    }

    public static List<Picture> findMyPhoto(String username){
        User user = UserDAO.findUser(username);
        String userID = user.getID();
        String sql = "SELECT * from travelimage WHERE UID = '" + userID + "'";
        return getPicList(sql);
    }
    public static List<Picture> findFavour(String username) {
        User user = UserDAO.findUser(username);
        String userID = user.getID();
        String sql = "SELECT * from travelimagefavor WHERE UID = '" + userID + "'";
        return getPicList(sql);
    }

    public static List<Picture> searchByTitle(String title,String order){
        String sql="SELECT * FROM travelimage WHERE Title LIKE '%"+title+"%' ORDER BY "+order+" DESC";
        return getPicList(sql);
    }
    public static List<Picture> searchByContent(String content,String order){
        String sql="SELECT * FROM travelimage WHERE Content LIKE '%"+content+"%' ORDER BY "+order+" DESC";
        return getPicList(sql);
    }

    private static List<Picture> getPicList(String sql){
        List<Picture> pictures = new ArrayList<>();
        Connection conn = jdbcUtil.getConnection();
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            pst = conn.prepareStatement(sql);
            rs = pst.executeQuery();
            while (rs.next()) {
                pictures.add(findPic(rs.getString("ImageID")));
            }
            return pictures;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            jdbcUtil.close(rs, pst, conn);
        }
    }

    public static int getFavourNum(String ID) {
        Connection conn = jdbcUtil.getConnection();
        String sql = "SELECT * from travelimagefavor WHERE ImageID = '" + ID + "'";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            pst = conn.prepareStatement(sql);
            rs = pst.executeQuery();
            rs.last();
            return rs.getRow();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        } finally {
            jdbcUtil.close(rs, pst, conn);
        }
    }

    public static boolean alreadyFavoured(String username, String imageID){
        String UID = UserDAO.getID(username);
        Connection conn = jdbcUtil.getConnection();
        String sql = "SELECT * from travelimagefavor WHERE UID=? AND ImageID=?";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            pst = conn.prepareStatement(sql);
            pst.setString(1, UID);
            pst.setString(2, imageID);
            rs = pst.executeQuery();
            if(rs.next()){
                return true;
            }else {
                return false;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            jdbcUtil.close(rs, pst, conn);
        }
    }

    public static void addToMyFavour(String UID, String imageID) {
        Connection conn = jdbcUtil.getConnection();
        String sql1 = "INSERT INTO travelimagefavor(UID,ImageID) values(?,?)";
        String sql2 = "UPDATE travelimage SET likeperson=likeperson+1 WHERE ImageID=?";
        PreparedStatement pst = null;
        PreparedStatement pst2=null;
        try {
            pst = conn.prepareStatement(sql1);
            pst2 = conn.prepareStatement(sql2);
            pst2.setString(1,imageID);
            pst.setString(1, UID);
            pst.setString(2, imageID);
            pst.execute();
            pst2.execute();

            pst2.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            jdbcUtil.close(null, pst, conn);
        }


    }

    public static void deleteMyFavour(String UID, String imageID) {
        Connection conn = jdbcUtil.getConnection();
        String sql = "DELETE FROM travelimagefavor WHERE UID=? AND ImageID=?";
        String sql2 = "UPDATE travelimage SET likeperson=likeperson-1 WHERE ImageID=?";
        PreparedStatement pst = null;
        PreparedStatement pst2=null;
        try {
            pst = conn.prepareStatement(sql);
            pst2 = conn.prepareStatement(sql2);
            pst2.setString(1,imageID);
            pst.setString(1, UID);
            pst.setString(2, imageID);
            pst.execute();
            pst2.execute();
            pst2.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            jdbcUtil.close(null, pst, conn);
        }
    }

    public static void save(Picture picture){
        Connection conn = jdbcUtil.getConnection();
        String sql="INSERT INTO travelimage(Title,Description,CityCode,Country_RegionCodeISO,UID,PATH,Content,likeperson) " +
                "VALUES (?,?,?,?,?,?,?,?)";
        PreparedStatement pst = null;
        try {
            pst = conn.prepareStatement(sql);
            pst.setString(1, picture.getTitle());
            pst.setString(2, picture.getDescription());
            pst.setString(3, RegionDAO.getCityCode(picture.getCityName()));
            pst.setString(4, RegionDAO.getCountryISO(picture.getCountryName()));
            pst.setString(5, UserDAO.getID(picture.getAuthor()));
            pst.setString(6,picture.getPath());
            pst.setString(7,picture.getContent());
            pst.setInt(8,0);
            pst.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            jdbcUtil.close(null, pst, conn);
        }

    }

    public static void update(Picture picture){
        Connection conn = jdbcUtil.getConnection();
        String sql="update travelimage SET Title = ?,Description=?,CityCode=?,Country_RegionCodeISO=?," +
                "UID=?,PATH=?,Content=?,likeperson=? WHERE ImageID= ?";
        PreparedStatement pst = null;
        try {
            pst = conn.prepareStatement(sql);
            pst.setString(1, picture.getTitle());
            pst.setString(2, picture.getDescription());
            pst.setString(3, RegionDAO.getCityCode(picture.getCityName()));
            pst.setString(4, RegionDAO.getCountryISO(picture.getCountryName()));
            pst.setString(5, UserDAO.getID(picture.getAuthor()));
            pst.setString(6,picture.getPath());
            pst.setString(7,picture.getContent());
            pst.setInt(8,0);
            pst.setString(9,picture.getID());
            pst.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            jdbcUtil.close(null, pst, conn);
        }
    }

    public static void delete(String id){
        Connection conn = jdbcUtil.getConnection();
        String sql="DELETE FROM travelimage WHERE ImageID="+id;
        String sql2="DELETE FROM travelimagefavor WHERE ImageID="+id;
        PreparedStatement pst = null;
        try {
            pst = conn.prepareStatement(sql);
            pst.execute();
            pst=conn.prepareStatement(sql2);
            pst.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            jdbcUtil.close(null, pst, conn);
        }

    }

    public static String parseToJson(List<Picture> pictures) {
        if (pictures.size() == 0)
            return "{\"results\":null}";
        String result = "";
        result += "{\"results\":[";
        String title="";
        for (Picture picture : pictures) {
            title=picture.getTitle();
            if(picture.getTitle().indexOf("'")>0){
                title=title.replace("'","\\'");
            }
            result += "{\"PATH\":\"" + picture.getPath() + "\"," +
                    " \"Title\":\"" + title+ "\"," +
                    " \"Author\":\"" + picture.getAuthor() + "\"," +
                    " \"likeperson\":\"" + picture.getLikePerson() + "\"," +
                    " \"ImageID\":\"" + picture.getID() + "\"},";
        }
        result = result.substring(0, result.length() - 1);
        result += "]}";
        return result;
    }

}
