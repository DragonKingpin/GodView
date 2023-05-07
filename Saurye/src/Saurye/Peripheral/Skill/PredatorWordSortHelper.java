package Saurye.Peripheral.Skill;

import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONException;

import java.util.Random;

public class PredatorWordSortHelper {
    public JSONArray sortShuffle(JSONArray that) throws JSONException {
        Random random = new Random();
        int ran = random.nextInt(100);
        System.out.println(ran);
        Object temp = null;
        while((ran--)!=0) {
            for (int i = 0; i < that.length() / 2; i++) {
                int index = i + that.length() / 2;
                temp = that.get(i);
                that.put(i, that.get(index));
                that.put(index, temp);
            }
        }
        return that;
    }

    public JSONArray sortQuickWordLength(JSONArray that) {
        that = sortQuickWordLength(that, 0, that.length() - 1);
        return that;
    }

    public JSONArray sortQuickWordLength(JSONArray that, int left, int right) throws JSONException {
        int i = left, j = right;
        if (i > j) return that;
        Object t = null;
        int tempLength = that.getJSONObject(i).optString("en_word").length();
        Object tempObject = that.get(i);
        while (i != j) {
            while (that.getJSONObject(j).optString("en_word").length() >= tempLength && i < j) {
                j--;
            }
            while (that.getJSONObject(i).optString("en_word").length() <= tempLength && i < j) {
                i++;
            }
            if (i < j) {
                t = that.get(j);
                that.put(j, that.get(i));
                that.put(i, t);
            }
        }
        that.put(left, that.get(i));
        that.put(i, tempObject);

        sortQuickWordLength(that, left, i - 1);
        sortQuickWordLength(that, i + 1, right);
        return that;
    }

//    public  JSONArray sortWithSQL(String szCheck, String Table[], Map Condition, String szSortTarget, String szSortType) throws SQLException, JSONException {
//        if (szCheck != null && szSortTarget !=null && Table!=null) {
//            String szSql = "Select " + szCheck;
//            int sum = 1;
//            szSql += " FROM ";
//            for(String item:Table){
//                szSql+= item;
//                if(sum < Table.length){
//                    szSql +=",";
//                    sum++;
//                }
//            }
//            if (Condition != null) {
//                szSql += " WHERE ";
//                sum = 1;
//                for (Object each : Condition.entrySet()) {
//                    Map.Entry item = (Map.Entry) each;
//                    szSql += item.getKey() + " = " + "'" + item.getValue() + "'";
//                    if (sum < Condition.size()) {
//                        szSql += " AND ";
//                        sum++;
//                    }
//                }
//            }
//            szSql+=" ORDER BY "+"'"+szSortTarget+"' "+szSortType;
//            return this.mysql().select(szSql);
//        }
//        return null;
//    }
}
