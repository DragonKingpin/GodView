<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>${pageTitle}</title>
    <style>
        .wrap {
            margin-top: 2%;
            margin-left: auto !important;
            margin-right: auto !important;
        }

        table {
            width: 860px !important;
            border-collapse: collapse;
            word-wrap:break-word;
            table-layout: fixed;
            word-break: break-all;
        }

        p {
            line-height: 18px !important;
        }

        td, th {
            padding: 6px;
            text-align: left;
            padding-left: 20px;
            font-size: 18px;
            color: black;
            font-weight: bold;
            border: 2px solid #ccc;
        }

        .back_th {
            border: 2px solid cornflowerblue;
            border-bottom: 2px solid white;
            background-color: cornflowerblue;
        }

        .back {
            text-decoration: none;
            font-size: 16px;
            color: white;
        }

        .title {
            text-align: center;
            font-size: 28px;
            padding: 10px;
            background-color: cornflowerblue;
            border: 2px solid cornflowerblue;
            color: white;
        }

        .center {
            text-align: center;
        }

        .red-200{
            color: orangered;
            font-size: 200%
        }
    </style>
</head>

<body>
<table class="wrap" align="center">
    <thead>
    <tr>
        <th class="back_th"><a class="back" href="#" onclick="javascript:history.back()">&lt; Back</a></th>
    </tr>
    <tr>
        <th class="title">BEAN NUTS PINECONE FOR JAVA</th>
    </tr>
    <tr>
        <th class="center red-200">WARNING</th>
    </tr>
    <tr>
        <th class="center red-200">${pageTitle}</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <th scope="col">
            <div style="float: left">
                <p>1. Pinecone Version: ${pineVersion} [Prime]</p>
                <p>2. Pinecone Release Date: ${pineReleaseDate}</p>
                <p>3. Java Version: ${javaVersion}</p>
                <p>4. Authors for Pinecone [MR.A.R.B], [MR.LONG], [MR.YUAN]</p>
                <p>5. Bean Nuts Hazelnut Sauron Demon Eyes</p>
            </div>
            <div style="float: right">
                <img src="/pinecone/assets/pinecone.png" />
                <p class="center" style="margin: 1%;font-size: 85%">Pinecone Ursus Java</p>
            </div>
        </th>
    </tr>
    <tr>
        <th>
            <div style="float: left;text-align: left;color: orangered;width: 80%;">
                ${errorMsg}
            </div>
            <div style="float: right;width: 20%;text-align: center">
                <img src="/pinecone/assets/avatar.png"/>
                <p class="center" style="margin: 1%;font-size: 85%;">undefined</p>
            </div>
        </th>
    </tr>
    <tr>
        <th>
            <div style="float: left">
                <p style="color: red">Pinecone has requested the runtime to terminate it in an unusual way. !</p>
                <p>Please contact the application's support team for more information.</p>
                <p>Contact: E-Mail:arb#rednest.cn</p>
            </div>
        </th>
    </tr>
    <tr>
        <th class="center" style="font-size: 90%">
            Pinecone is a powerful runtime framework for Java, it supports versatile kits, helping fast building.
        </th>
    </tr>
    <tr>
        <th class="center">
            <p id="copyright">Copyright(C)2008-2028 Bean Nuts Foundation All rights reserved. </p>
        </th>
    </tr>
    <tr>
        <th class="center">
            <p id="information" style="font-size: 80%">
                For More Information Visit:
                <a href="https://www.xbean.net" target="_blank">https://www.xbean.net</a> |
                <a href="http://www.rednest.cn" target="_blank">http://www.rednest.cn</a> |
                <a href="http://www.nutgit.com" target="_blank">http://www.nutgit.com</a>
            </p>
        </th>
    </tr>
    <tr>
        <th class="center">
            <p id="Pinecone">Powered by : BEAN NUTS PINECONE FOR JAVA</p>
        </th>
    </tr>
    </tbody>
</table>
</body>
</html>