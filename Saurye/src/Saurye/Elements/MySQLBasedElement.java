package Saurye.Elements;

import Pinecone.Framework.Util.RDB.MySQL.MySQLExecutor;
import Saurye.System.Prototype.Element;

public interface MySQLBasedElement extends Element {
    MySQLExecutor mysql();
}
