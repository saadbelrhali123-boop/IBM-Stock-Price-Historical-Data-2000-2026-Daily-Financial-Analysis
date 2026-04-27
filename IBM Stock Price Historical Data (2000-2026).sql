SELECT 
    MIN(trading_date) as Date_Debut,
    MAX(trading_date) as Date_Fin,
    COUNT(*) as Total_Jours_Bourse,
    (SELECT Close FROM ibm ORDER BY trading_date ASC LIMIT 1) as Prix_Initial,
    (SELECT Close FROM ibm ORDER BY trading_date DESC LIMIT 1) as Prix_Final,
    ROUND((( (SELECT Close FROM ibm ORDER BY trading_date DESC LIMIT 1) - (SELECT Close FROM ibm ORDER BY trading_date ASC LIMIT 1) ) 
    / (SELECT Close FROM ibm ORDER BY trading_date ASC LIMIT 1) * 100), 2) as Performance_Globale_Pct
FROM ibm;