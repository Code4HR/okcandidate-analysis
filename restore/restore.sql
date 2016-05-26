--
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

ALTER TABLE ONLY public.survey_response DROP CONSTRAINT survey_response_survey_id_fkey;
ALTER TABLE ONLY public.survey_response DROP CONSTRAINT survey_response_geography_id_fkey;
ALTER TABLE ONLY public.survey_answer DROP CONSTRAINT survey_answer_survey_response_id_fkey;
ALTER TABLE ONLY public.survey_answer DROP CONSTRAINT survey_answer_question_id_fkey;
ALTER TABLE ONLY public.survey_answer DROP CONSTRAINT survey_answer_answer_id_fkey;
ALTER TABLE ONLY public.question DROP CONSTRAINT question_survey_id_fkey;
ALTER TABLE ONLY public.question DROP CONSTRAINT question_category_id_fkey;
ALTER TABLE ONLY public.candidate_geography DROP CONSTRAINT candidate_geography_geography_id_fkey;
ALTER TABLE ONLY public.candidate_geography DROP CONSTRAINT candidate_geography_candidate_id_fkey;
ALTER TABLE ONLY public.candidate DROP CONSTRAINT candidate_candidate_type_id_fkey;
ALTER TABLE ONLY public.candidate_answer DROP CONSTRAINT candidate_answer_question_id_fkey;
ALTER TABLE ONLY public.candidate_answer DROP CONSTRAINT candidate_answer_candidate_id_fkey;
ALTER TABLE ONLY public.candidate_answer DROP CONSTRAINT candidate_answer_answer_id_fkey;
ALTER TABLE ONLY public.answer DROP CONSTRAINT answer_question_id_fkey;
ALTER TABLE ONLY public.survey_response DROP CONSTRAINT survey_response_pkey;
ALTER TABLE ONLY public.survey DROP CONSTRAINT survey_pkey;
ALTER TABLE ONLY public.survey_answer DROP CONSTRAINT survey_answer_pkey;
ALTER TABLE ONLY public.question DROP CONSTRAINT question_pkey;
ALTER TABLE ONLY public.geography DROP CONSTRAINT geography_pkey;
ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
ALTER TABLE ONLY public.candidate_type DROP CONSTRAINT candidate_type_pkey;
ALTER TABLE ONLY public.candidate DROP CONSTRAINT candidate_pkey;
ALTER TABLE ONLY public.candidate_geography DROP CONSTRAINT candidate_geography_pkey;
ALTER TABLE ONLY public.candidate_answer DROP CONSTRAINT candidate_answer_pkey;
ALTER TABLE ONLY public.answer DROP CONSTRAINT answer_pkey;
ALTER TABLE public.survey_response ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.survey_answer ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.survey ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.question ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.geography ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.category ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.candidate_type ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.candidate_geography ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.candidate_answer ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.candidate ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.answer ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.survey_response_id_seq;
DROP TABLE public.survey_response;
DROP SEQUENCE public.survey_id_seq;
DROP SEQUENCE public.survey_answer_id_seq;
DROP TABLE public.survey_answer;
DROP TABLE public.survey;
DROP SEQUENCE public.question_id_seq;
DROP TABLE public.question;
DROP SEQUENCE public.geography_id_seq;
DROP TABLE public.geography;
DROP SEQUENCE public.category_id_seq;
DROP TABLE public.category;
DROP SEQUENCE public.candidate_type_id_seq;
DROP TABLE public.candidate_type;
DROP SEQUENCE public.candidate_id_seq;
DROP SEQUENCE public.candidate_geography_id_seq;
DROP TABLE public.candidate_geography;
DROP SEQUENCE public.candidate_answer_id_seq;
DROP TABLE public.candidate_answer;
DROP TABLE public.candidate;
DROP SEQUENCE public.answer_id_seq;
DROP TABLE public.answer;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: answer; Type: TABLE; Schema: public; Owner: okc; Tablespace: 
--

CREATE TABLE answer (
    id integer NOT NULL,
    question_id integer NOT NULL,
    answer_label character varying(255) NOT NULL,
    answer_value character varying(255) NOT NULL
);


ALTER TABLE answer OWNER TO okc;

--
-- Name: answer_id_seq; Type: SEQUENCE; Schema: public; Owner: okc
--

CREATE SEQUENCE answer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE answer_id_seq OWNER TO okc;

--
-- Name: answer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: okc
--

ALTER SEQUENCE answer_id_seq OWNED BY answer.id;


--
-- Name: candidate; Type: TABLE; Schema: public; Owner: okc; Tablespace: 
--

CREATE TABLE candidate (
    id integer NOT NULL,
    candidate_name character varying(100),
    candidate_img character varying(100),
    candidate_website character varying(100),
    candidate_type_id integer NOT NULL
);


ALTER TABLE candidate OWNER TO okc;

--
-- Name: candidate_answer; Type: TABLE; Schema: public; Owner: okc; Tablespace: 
--

CREATE TABLE candidate_answer (
    id integer NOT NULL,
    candidate_id integer NOT NULL,
    question_id integer NOT NULL,
    answer_id integer NOT NULL,
    intensity integer
);


ALTER TABLE candidate_answer OWNER TO okc;

--
-- Name: candidate_answer_id_seq; Type: SEQUENCE; Schema: public; Owner: okc
--

CREATE SEQUENCE candidate_answer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE candidate_answer_id_seq OWNER TO okc;

--
-- Name: candidate_answer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: okc
--

ALTER SEQUENCE candidate_answer_id_seq OWNED BY candidate_answer.id;


--
-- Name: candidate_geography; Type: TABLE; Schema: public; Owner: okc; Tablespace: 
--

CREATE TABLE candidate_geography (
    id integer NOT NULL,
    candidate_id integer NOT NULL,
    geography_id integer NOT NULL
);


ALTER TABLE candidate_geography OWNER TO okc;

--
-- Name: candidate_geography_id_seq; Type: SEQUENCE; Schema: public; Owner: okc
--

CREATE SEQUENCE candidate_geography_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE candidate_geography_id_seq OWNER TO okc;

--
-- Name: candidate_geography_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: okc
--

ALTER SEQUENCE candidate_geography_id_seq OWNED BY candidate_geography.id;


--
-- Name: candidate_id_seq; Type: SEQUENCE; Schema: public; Owner: okc
--

CREATE SEQUENCE candidate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE candidate_id_seq OWNER TO okc;

--
-- Name: candidate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: okc
--

ALTER SEQUENCE candidate_id_seq OWNED BY candidate.id;


--
-- Name: candidate_type; Type: TABLE; Schema: public; Owner: okc; Tablespace: 
--

CREATE TABLE candidate_type (
    id integer NOT NULL,
    type_name character varying(100)
);


ALTER TABLE candidate_type OWNER TO okc;

--
-- Name: candidate_type_id_seq; Type: SEQUENCE; Schema: public; Owner: okc
--

CREATE SEQUENCE candidate_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE candidate_type_id_seq OWNER TO okc;

--
-- Name: candidate_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: okc
--

ALTER SEQUENCE candidate_type_id_seq OWNED BY candidate_type.id;


--
-- Name: category; Type: TABLE; Schema: public; Owner: okc; Tablespace: 
--

CREATE TABLE category (
    id integer NOT NULL,
    category_name character varying(100) NOT NULL
);


ALTER TABLE category OWNER TO okc;

--
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: okc
--

CREATE SEQUENCE category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE category_id_seq OWNER TO okc;

--
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: okc
--

ALTER SEQUENCE category_id_seq OWNED BY category.id;


--
-- Name: geography; Type: TABLE; Schema: public; Owner: okc; Tablespace: 
--

CREATE TABLE geography (
    id integer NOT NULL,
    geography_name character varying(100)
);


ALTER TABLE geography OWNER TO okc;

--
-- Name: geography_id_seq; Type: SEQUENCE; Schema: public; Owner: okc
--

CREATE SEQUENCE geography_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE geography_id_seq OWNER TO okc;

--
-- Name: geography_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: okc
--

ALTER SEQUENCE geography_id_seq OWNED BY geography.id;


--
-- Name: question; Type: TABLE; Schema: public; Owner: okc; Tablespace: 
--

CREATE TABLE question (
    id integer NOT NULL,
    survey_id integer NOT NULL,
    category_id integer,
    question_text character varying(255) NOT NULL
);


ALTER TABLE question OWNER TO okc;

--
-- Name: question_id_seq; Type: SEQUENCE; Schema: public; Owner: okc
--

CREATE SEQUENCE question_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE question_id_seq OWNER TO okc;

--
-- Name: question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: okc
--

ALTER SEQUENCE question_id_seq OWNED BY question.id;


--
-- Name: survey; Type: TABLE; Schema: public; Owner: okc; Tablespace: 
--

CREATE TABLE survey (
    id integer NOT NULL,
    survey_name character varying(255) NOT NULL
);


ALTER TABLE survey OWNER TO okc;

--
-- Name: survey_answer; Type: TABLE; Schema: public; Owner: okc; Tablespace: 
--

CREATE TABLE survey_answer (
    id integer NOT NULL,
    survey_response_id integer NOT NULL,
    question_id integer NOT NULL,
    answer_id integer NOT NULL,
    intensity integer
);


ALTER TABLE survey_answer OWNER TO okc;

--
-- Name: survey_answer_id_seq; Type: SEQUENCE; Schema: public; Owner: okc
--

CREATE SEQUENCE survey_answer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE survey_answer_id_seq OWNER TO okc;

--
-- Name: survey_answer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: okc
--

ALTER SEQUENCE survey_answer_id_seq OWNED BY survey_answer.id;


--
-- Name: survey_id_seq; Type: SEQUENCE; Schema: public; Owner: okc
--

CREATE SEQUENCE survey_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE survey_id_seq OWNER TO okc;

--
-- Name: survey_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: okc
--

ALTER SEQUENCE survey_id_seq OWNED BY survey.id;


--
-- Name: survey_response; Type: TABLE; Schema: public; Owner: okc; Tablespace: 
--

CREATE TABLE survey_response (
    id integer NOT NULL,
    survey_id integer NOT NULL,
    geography_id integer NOT NULL
);


ALTER TABLE survey_response OWNER TO okc;

--
-- Name: survey_response_id_seq; Type: SEQUENCE; Schema: public; Owner: okc
--

CREATE SEQUENCE survey_response_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE survey_response_id_seq OWNER TO okc;

--
-- Name: survey_response_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: okc
--

ALTER SEQUENCE survey_response_id_seq OWNED BY survey_response.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: okc
--

ALTER TABLE ONLY answer ALTER COLUMN id SET DEFAULT nextval('answer_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: okc
--

ALTER TABLE ONLY candidate ALTER COLUMN id SET DEFAULT nextval('candidate_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: okc
--

ALTER TABLE ONLY candidate_answer ALTER COLUMN id SET DEFAULT nextval('candidate_answer_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: okc
--

ALTER TABLE ONLY candidate_geography ALTER COLUMN id SET DEFAULT nextval('candidate_geography_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: okc
--

ALTER TABLE ONLY candidate_type ALTER COLUMN id SET DEFAULT nextval('candidate_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: okc
--

ALTER TABLE ONLY category ALTER COLUMN id SET DEFAULT nextval('category_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: okc
--

ALTER TABLE ONLY geography ALTER COLUMN id SET DEFAULT nextval('geography_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: okc
--

ALTER TABLE ONLY question ALTER COLUMN id SET DEFAULT nextval('question_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: okc
--

ALTER TABLE ONLY survey ALTER COLUMN id SET DEFAULT nextval('survey_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: okc
--

ALTER TABLE ONLY survey_answer ALTER COLUMN id SET DEFAULT nextval('survey_answer_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: okc
--

ALTER TABLE ONLY survey_response ALTER COLUMN id SET DEFAULT nextval('survey_response_id_seq'::regclass);


--
-- Data for Name: answer; Type: TABLE DATA; Schema: public; Owner: okc
--

COPY answer (id, question_id, answer_label, answer_value) FROM stdin;
\.
COPY answer (id, question_id, answer_label, answer_value) FROM '$$PATH$$/2109.dat';

--
-- Name: answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: okc
--

SELECT pg_catalog.setval('answer_id_seq', 1, false);


--
-- Data for Name: candidate; Type: TABLE DATA; Schema: public; Owner: okc
--

COPY candidate (id, candidate_name, candidate_img, candidate_website, candidate_type_id) FROM stdin;
\.
COPY candidate (id, candidate_name, candidate_img, candidate_website, candidate_type_id) FROM '$$PATH$$/2117.dat';

--
-- Data for Name: candidate_answer; Type: TABLE DATA; Schema: public; Owner: okc
--

COPY candidate_answer (id, candidate_id, question_id, answer_id, intensity) FROM stdin;
\.
COPY candidate_answer (id, candidate_id, question_id, answer_id, intensity) FROM '$$PATH$$/2119.dat';

--
-- Name: candidate_answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: okc
--

SELECT pg_catalog.setval('candidate_answer_id_seq', 1, false);


--
-- Data for Name: candidate_geography; Type: TABLE DATA; Schema: public; Owner: okc
--

COPY candidate_geography (id, candidate_id, geography_id) FROM stdin;
\.
COPY candidate_geography (id, candidate_id, geography_id) FROM '$$PATH$$/2121.dat';

--
-- Name: candidate_geography_id_seq; Type: SEQUENCE SET; Schema: public; Owner: okc
--

SELECT pg_catalog.setval('candidate_geography_id_seq', 13, true);


--
-- Name: candidate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: okc
--

SELECT pg_catalog.setval('candidate_id_seq', 1, false);


--
-- Data for Name: candidate_type; Type: TABLE DATA; Schema: public; Owner: okc
--

COPY candidate_type (id, type_name) FROM stdin;
\.
COPY candidate_type (id, type_name) FROM '$$PATH$$/2115.dat';

--
-- Name: candidate_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: okc
--

SELECT pg_catalog.setval('candidate_type_id_seq', 1, false);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: okc
--

COPY category (id, category_name) FROM stdin;
\.
COPY category (id, category_name) FROM '$$PATH$$/2105.dat';

--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: okc
--

SELECT pg_catalog.setval('category_id_seq', 1, false);


--
-- Data for Name: geography; Type: TABLE DATA; Schema: public; Owner: okc
--

COPY geography (id, geography_name) FROM stdin;
\.
COPY geography (id, geography_name) FROM '$$PATH$$/2101.dat';

--
-- Name: geography_id_seq; Type: SEQUENCE SET; Schema: public; Owner: okc
--

SELECT pg_catalog.setval('geography_id_seq', 1, false);


--
-- Data for Name: question; Type: TABLE DATA; Schema: public; Owner: okc
--

COPY question (id, survey_id, category_id, question_text) FROM stdin;
\.
COPY question (id, survey_id, category_id, question_text) FROM '$$PATH$$/2107.dat';

--
-- Name: question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: okc
--

SELECT pg_catalog.setval('question_id_seq', 1, false);


--
-- Data for Name: survey; Type: TABLE DATA; Schema: public; Owner: okc
--

COPY survey (id, survey_name) FROM stdin;
\.
COPY survey (id, survey_name) FROM '$$PATH$$/2103.dat';

--
-- Data for Name: survey_answer; Type: TABLE DATA; Schema: public; Owner: okc
--

COPY survey_answer (id, survey_response_id, question_id, answer_id, intensity) FROM stdin;
\.
COPY survey_answer (id, survey_response_id, question_id, answer_id, intensity) FROM '$$PATH$$/2113.dat';

--
-- Name: survey_answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: okc
--

SELECT pg_catalog.setval('survey_answer_id_seq', 36487, true);


--
-- Name: survey_id_seq; Type: SEQUENCE SET; Schema: public; Owner: okc
--

SELECT pg_catalog.setval('survey_id_seq', 1, false);


--
-- Data for Name: survey_response; Type: TABLE DATA; Schema: public; Owner: okc
--

COPY survey_response (id, survey_id, geography_id) FROM stdin;
\.
COPY survey_response (id, survey_id, geography_id) FROM '$$PATH$$/2111.dat';

--
-- Name: survey_response_id_seq; Type: SEQUENCE SET; Schema: public; Owner: okc
--

SELECT pg_catalog.setval('survey_response_id_seq', 1213, true);


--
-- Name: answer_pkey; Type: CONSTRAINT; Schema: public; Owner: okc; Tablespace: 
--

ALTER TABLE ONLY answer
    ADD CONSTRAINT answer_pkey PRIMARY KEY (id);


--
-- Name: candidate_answer_pkey; Type: CONSTRAINT; Schema: public; Owner: okc; Tablespace: 
--

ALTER TABLE ONLY candidate_answer
    ADD CONSTRAINT candidate_answer_pkey PRIMARY KEY (id);


--
-- Name: candidate_geography_pkey; Type: CONSTRAINT; Schema: public; Owner: okc; Tablespace: 
--

ALTER TABLE ONLY candidate_geography
    ADD CONSTRAINT candidate_geography_pkey PRIMARY KEY (id);


--
-- Name: candidate_pkey; Type: CONSTRAINT; Schema: public; Owner: okc; Tablespace: 
--

ALTER TABLE ONLY candidate
    ADD CONSTRAINT candidate_pkey PRIMARY KEY (id);


--
-- Name: candidate_type_pkey; Type: CONSTRAINT; Schema: public; Owner: okc; Tablespace: 
--

ALTER TABLE ONLY candidate_type
    ADD CONSTRAINT candidate_type_pkey PRIMARY KEY (id);


--
-- Name: category_pkey; Type: CONSTRAINT; Schema: public; Owner: okc; Tablespace: 
--

ALTER TABLE ONLY category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: geography_pkey; Type: CONSTRAINT; Schema: public; Owner: okc; Tablespace: 
--

ALTER TABLE ONLY geography
    ADD CONSTRAINT geography_pkey PRIMARY KEY (id);


--
-- Name: question_pkey; Type: CONSTRAINT; Schema: public; Owner: okc; Tablespace: 
--

ALTER TABLE ONLY question
    ADD CONSTRAINT question_pkey PRIMARY KEY (id);


--
-- Name: survey_answer_pkey; Type: CONSTRAINT; Schema: public; Owner: okc; Tablespace: 
--

ALTER TABLE ONLY survey_answer
    ADD CONSTRAINT survey_answer_pkey PRIMARY KEY (id);


--
-- Name: survey_pkey; Type: CONSTRAINT; Schema: public; Owner: okc; Tablespace: 
--

ALTER TABLE ONLY survey
    ADD CONSTRAINT survey_pkey PRIMARY KEY (id);


--
-- Name: survey_response_pkey; Type: CONSTRAINT; Schema: public; Owner: okc; Tablespace: 
--

ALTER TABLE ONLY survey_response
    ADD CONSTRAINT survey_response_pkey PRIMARY KEY (id);


--
-- Name: answer_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: okc
--

ALTER TABLE ONLY answer
    ADD CONSTRAINT answer_question_id_fkey FOREIGN KEY (question_id) REFERENCES question(id);


--
-- Name: candidate_answer_answer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: okc
--

ALTER TABLE ONLY candidate_answer
    ADD CONSTRAINT candidate_answer_answer_id_fkey FOREIGN KEY (answer_id) REFERENCES answer(id);


--
-- Name: candidate_answer_candidate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: okc
--

ALTER TABLE ONLY candidate_answer
    ADD CONSTRAINT candidate_answer_candidate_id_fkey FOREIGN KEY (candidate_id) REFERENCES candidate(id);


--
-- Name: candidate_answer_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: okc
--

ALTER TABLE ONLY candidate_answer
    ADD CONSTRAINT candidate_answer_question_id_fkey FOREIGN KEY (question_id) REFERENCES question(id);


--
-- Name: candidate_candidate_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: okc
--

ALTER TABLE ONLY candidate
    ADD CONSTRAINT candidate_candidate_type_id_fkey FOREIGN KEY (candidate_type_id) REFERENCES candidate_type(id);


--
-- Name: candidate_geography_candidate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: okc
--

ALTER TABLE ONLY candidate_geography
    ADD CONSTRAINT candidate_geography_candidate_id_fkey FOREIGN KEY (candidate_id) REFERENCES candidate(id);


--
-- Name: candidate_geography_geography_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: okc
--

ALTER TABLE ONLY candidate_geography
    ADD CONSTRAINT candidate_geography_geography_id_fkey FOREIGN KEY (geography_id) REFERENCES geography(id);


--
-- Name: question_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: okc
--

ALTER TABLE ONLY question
    ADD CONSTRAINT question_category_id_fkey FOREIGN KEY (category_id) REFERENCES category(id);


--
-- Name: question_survey_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: okc
--

ALTER TABLE ONLY question
    ADD CONSTRAINT question_survey_id_fkey FOREIGN KEY (survey_id) REFERENCES survey(id);


--
-- Name: survey_answer_answer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: okc
--

ALTER TABLE ONLY survey_answer
    ADD CONSTRAINT survey_answer_answer_id_fkey FOREIGN KEY (answer_id) REFERENCES answer(id);


--
-- Name: survey_answer_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: okc
--

ALTER TABLE ONLY survey_answer
    ADD CONSTRAINT survey_answer_question_id_fkey FOREIGN KEY (question_id) REFERENCES question(id);


--
-- Name: survey_answer_survey_response_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: okc
--

ALTER TABLE ONLY survey_answer
    ADD CONSTRAINT survey_answer_survey_response_id_fkey FOREIGN KEY (survey_response_id) REFERENCES survey_response(id);


--
-- Name: survey_response_geography_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: okc
--

ALTER TABLE ONLY survey_response
    ADD CONSTRAINT survey_response_geography_id_fkey FOREIGN KEY (geography_id) REFERENCES geography(id);


--
-- Name: survey_response_survey_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: okc
--

ALTER TABLE ONLY survey_response
    ADD CONSTRAINT survey_response_survey_id_fkey FOREIGN KEY (survey_id) REFERENCES survey(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

