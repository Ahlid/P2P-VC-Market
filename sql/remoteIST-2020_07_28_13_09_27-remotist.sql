--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_with_oids = false;

create extension if not exists "uuid-ossp";

--
-- Name: hearthz; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hearthz (
    "timestamp" timestamp without time zone DEFAULT now() NOT NULL,
    machine_id uuid NOT NULL,
    disc integer,
    "RAM" integer,
    "CPU" integer,
    network integer,
    jobs integer,
    ip character varying(255),
    session_id uuid
);


ALTER TABLE public.hearthz OWNER TO postgres;

--
-- Name: Job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Job" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    disc integer,
    "RAM" integer,
    exec_time double precision,
    status character varying(255),
    price integer,
    deadline timestamp without time zone,
    init_time timestamp without time zone,
    r_data_path character varying(255),
    folder_path character varying(255),
    mean_up_time double precision,
    user_id uuid,
    name character varying(255),
    "CPU" integer,
    exec_file character varying(255),
    "partialResultsVars" jsonb
);


ALTER TABLE public."Job" OWNER TO postgres;

--
-- Name: Machine; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Machine" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255),
    "CPU" integer,
    disc integer,
    "RAM" integer,
    price integer,
    scj integer,
    credibility integer,
    user_id uuid NOT NULL
);


ALTER TABLE public."Machine" OWNER TO postgres;

--
-- Name: Token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Token" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    revoked boolean DEFAULT false,
    subject_type character varying(255),
    subject_id uuid NOT NULL
);


ALTER TABLE public."Token" OWNER TO postgres;

--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    password character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    credits integer DEFAULT 0,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- Name: Volunteer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Volunteer" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    machine_id uuid NOT NULL,
    ip character varying(255),
    port integer,
    state character varying(50),
    created_at timestamp without time zone DEFAULT now(),
    session_id uuid NOT NULL,
    stoped boolean DEFAULT false,
    timeouted boolean DEFAULT false
);


ALTER TABLE public."Volunteer" OWNER TO postgres;

--
-- Name: partial_results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.partial_results (
    id uuid DEFAULT public.uuid_generate_v4(),
    name character varying,
    job_id uuid,
    value bytea,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.partial_results OWNER TO postgres;

--
-- Name: peer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.peer (
    peer_id uuid NOT NULL,
    super_peer_id uuid NOT NULL,
    disk integer,
    credits integer,
    host character varying,
    cpu integer,
    ram integer,
    created_at timestamp with time zone DEFAULT now(),
    port integer
);


ALTER TABLE public.peer OWNER TO postgres;


--
-- Data for Name: Job; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('ddc5d04c-321f-493d-8658-11bd279ed5aa', 100, 100, NULL, 'UNBOUND', 15, '2019-08-09 23:03:43', NULL, NULL, NULL, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('223a3c29-197b-4d92-85a8-3ab844a62544', 100, 100, NULL, 'UNBOUND', 15, '2019-08-09 23:09:31', NULL, NULL, NULL, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('2cb4fb70-8b40-4bc0-a5bf-022d402651c0', 100, 100, NULL, 'UNBOUND', 15, '2019-08-09 23:11:19', NULL, NULL, NULL, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('2c7e44b9-fa46-4760-9ca8-f51b63088cd5', 100, 100, NULL, 'UNBOUND', 15, '2019-08-09 23:12:09', NULL, NULL, NULL, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('5cfbba72-8a43-4c1b-99be-ae1f7b3654b2', 100, 100, NULL, 'UNBOUND', 15, '2019-08-09 23:21:46', NULL, NULL, NULL, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('594f1b2d-8565-4c68-a4ae-38011dd3f782', 100, 100, NULL, 'UNBOUND', 15, '2019-08-09 23:22:44', NULL, NULL, NULL, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('e5f42a0b-96a7-4901-8245-d6e86bae3e39', 100, 100, NULL, 'UNBOUND', 15, '2019-08-09 23:24:58', NULL, NULL, NULL, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('e9ff74f3-f6b5-4101-8c77-5d4faac6b7f2', 100, 100, NULL, 'UNBOUND', 15, '2019-08-09 23:28:07', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/{e9ff74f3-f6b5-4101-8c77-5d4faac6b7f2}_input.RData', NULL, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('0c71ffaa-34d4-46d4-8d98-2bada426d59b', 100, 100, NULL, 'UNBOUND', 15, '2019-08-09 23:31:40', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/0c71ffaa-34d4-46d4-8d98-2bada426d59b_input.RData', NULL, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('62ac18c1-b3f8-4129-b09d-c252e105de73', 100, 100, NULL, 'UNBOUND', 15, '2019-08-09 23:39:51', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/62ac18c1-b3f8-4129-b09d-c252e105de73_input.RData', NULL, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('152782ec-fa0a-43d0-9fac-5ea05460d91f', 100, 100, NULL, 'UNBOUND', 15, '2019-08-09 23:40:13', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/152782ec-fa0a-43d0-9fac-5ea05460d91f_input.RData', NULL, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('f6a13fdf-617d-4828-ba06-36bd81f622a9', 100, 100, NULL, 'UNBOUND', 15, '2019-08-09 23:41:35', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/f6a13fdf-617d-4828-ba06-36bd81f622a9_input.RData', NULL, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('2bcbb0fb-0e43-484d-a374-181d310b37b1', 100, 100, NULL, 'UNBOUND', 15, '2019-08-09 23:44:55', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/2bcbb0fb-0e43-484d-a374-181d310b37b1_input.RData', NULL, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('2c081202-223a-4f76-a419-1f54c6099ccd', 100, 100, NULL, 'UNBOUND', 15, '2019-08-09 23:46:13', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/2c081202-223a-4f76-a419-1f54c6099ccd_input.RData', NULL, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('67750668-5f17-4387-865c-8d297b925e6b', 100, 100, NULL, 'UNBOUND', 15, '2019-08-09 23:49:28', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/67750668-5f17-4387-865c-8d297b925e6b_input.RData', NULL, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('f77a823c-d0f0-4c83-a64e-801f51a19e8d', 100, 100, NULL, 'UNBOUND', 15, '2019-08-09 23:52:05', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/f77a823c-d0f0-4c83-a64e-801f51a19e8d_input.RData', NULL, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('79baeea7-197c-4ff0-88fa-8d315538f3cc', 100, 100, NULL, 'UNBOUND', 15, '2019-08-09 23:53:38', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/79baeea7-197c-4ff0-88fa-8d315538f3cc_input.RData', NULL, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('5629ec6e-d316-4a7b-aaa5-812f8d9c2fdd', 100, 100, NULL, 'UNBOUND', 15, '2019-08-09 23:58:10', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/5629ec6e-d316-4a7b-aaa5-812f8d9c2fdd_input.RData', NULL, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('41dd4399-1532-438b-b70e-69872c06f4f4', 100, 100, NULL, 'UNBOUND', 15, '2019-08-10 12:08:35', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/41dd4399-1532-438b-b70e-69872c06f4f4_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/41dd4399-1532-438b-b70e-69872c06f4f4.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('8f636e2e-e41f-451f-8970-ca0575a4431a', 100, 100, NULL, 'UNBOUND', 15, '2019-08-09 23:58:39', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/8f636e2e-e41f-451f-8970-ca0575a4431a_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/8f636e2e-e41f-451f-8970-ca0575a4431a.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('f74c7008-1760-42fa-ba1c-4f4499cf2ac8', 100, 100, NULL, 'UNBOUND', 15, '2019-08-10 00:00:46', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/f74c7008-1760-42fa-ba1c-4f4499cf2ac8_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/f74c7008-1760-42fa-ba1c-4f4499cf2ac8.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('292c808f-ab38-4329-ab8c-3c74d0c5b801', 100, 100, NULL, 'UNBOUND', 15, '2019-08-10 12:08:43', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/292c808f-ab38-4329-ab8c-3c74d0c5b801_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/292c808f-ab38-4329-ab8c-3c74d0c5b801.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('a9fa7f60-926e-4a48-b1da-417638a93ccb', 100, 100, NULL, 'UNBOUND', 15, '2019-08-10 12:08:32', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/a9fa7f60-926e-4a48-b1da-417638a93ccb_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/a9fa7f60-926e-4a48-b1da-417638a93ccb.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('665f4729-4081-4aa0-ab4a-b2ab1c7c5341', 100, 100, NULL, 'UNBOUND', 15, '2019-08-10 12:08:38', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/665f4729-4081-4aa0-ab4a-b2ab1c7c5341_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/665f4729-4081-4aa0-ab4a-b2ab1c7c5341.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('9a74b7d9-27a3-45b3-b24c-65d6d43466c7', 100, 100, NULL, 'UNBOUND', 15, '2019-08-10 12:08:49', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/9a74b7d9-27a3-45b3-b24c-65d6d43466c7_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/9a74b7d9-27a3-45b3-b24c-65d6d43466c7.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('a906ab88-25b6-4ed7-9d62-9fedba05c8c4', 100, 100, NULL, 'UNBOUND', 15, '2019-08-10 12:08:40', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/a906ab88-25b6-4ed7-9d62-9fedba05c8c4_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/a906ab88-25b6-4ed7-9d62-9fedba05c8c4.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('04a884d9-8465-4a00-878d-0ccc85b996a2', 100, 100, NULL, 'UNBOUND', 15, '2019-08-10 12:08:45', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/04a884d9-8465-4a00-878d-0ccc85b996a2_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/04a884d9-8465-4a00-878d-0ccc85b996a2.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('1abb3b1c-a33f-4ebb-89ba-c9f8b47cd07a', 100, 100, NULL, 'UNBOUND', 15, '2019-08-10 12:08:42', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/1abb3b1c-a33f-4ebb-89ba-c9f8b47cd07a_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/1abb3b1c-a33f-4ebb-89ba-c9f8b47cd07a.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('0d39d4cd-f3d5-4106-8912-c87ed69e9bbd', 100, 100, NULL, 'UNBOUND', 15, '2019-08-10 12:08:50', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/0d39d4cd-f3d5-4106-8912-c87ed69e9bbd_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/0d39d4cd-f3d5-4106-8912-c87ed69e9bbd.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('c0ba9be0-c64c-436a-bce8-e2e7d5f71164', 100, 100, NULL, 'UNBOUND', 15, '2019-08-10 12:08:51', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/c0ba9be0-c64c-436a-bce8-e2e7d5f71164_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/c0ba9be0-c64c-436a-bce8-e2e7d5f71164.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('082724e2-ffe3-4fc5-9a51-447369b2882b', 100, 100, NULL, 'UNBOUND', 15, '2019-08-10 12:08:54', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/082724e2-ffe3-4fc5-9a51-447369b2882b_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/082724e2-ffe3-4fc5-9a51-447369b2882b.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('304d3a4e-f33e-40e3-82b2-063cf52fddb9', 100, 100, NULL, 'UNBOUND', 15, '2019-08-10 12:08:56', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/304d3a4e-f33e-40e3-82b2-063cf52fddb9_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/304d3a4e-f33e-40e3-82b2-063cf52fddb9.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('8a047c26-97e2-4706-a722-0d6df9eee5d7', 100, 100, NULL, 'UNBOUND', 15, '2019-08-10 12:08:58', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/8a047c26-97e2-4706-a722-0d6df9eee5d7_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/8a047c26-97e2-4706-a722-0d6df9eee5d7.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('b1402634-ce11-4c9c-80ec-eb562160877f', 100, 100, NULL, 'UNBOUND', 15, '2019-08-24 22:42:37', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/b1402634-ce11-4c9c-80ec-eb562160877f_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/b1402634-ce11-4c9c-80ec-eb562160877f.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('959da684-2ec0-4d76-961a-15c293da7b3a', 100, 100, NULL, 'UNBOUND', 15, '2019-08-10 12:09:00', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/959da684-2ec0-4d76-961a-15c293da7b3a_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/959da684-2ec0-4d76-961a-15c293da7b3a.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('95fcdf28-7465-4186-8f2b-bbde741e53d2', 100, 100, NULL, 'UNBOUND', 15, '2019-08-10 12:09:01', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/95fcdf28-7465-4186-8f2b-bbde741e53d2_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/95fcdf28-7465-4186-8f2b-bbde741e53d2.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('eb3bbc3f-f849-45c9-a297-8e497d48a858', 100, 100, NULL, 'UNBOUND', 15, '2019-08-28 13:50:18', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/eb3bbc3f-f849-45c9-a297-8e497d48a858_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/eb3bbc3f-f849-45c9-a297-8e497d48a858.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('ee6d0077-c458-4196-9b0c-9e8100b57b67', 100, 100, NULL, 'UNBOUND', 15, '2019-08-10 12:09:23', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/ee6d0077-c458-4196-9b0c-9e8100b57b67_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/ee6d0077-c458-4196-9b0c-9e8100b57b67.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('f1f624e2-33e7-468d-8e49-266be8d7586c', 100, 100, NULL, 'UNBOUND', 15, '2019-08-25 15:56:36', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/f1f624e2-33e7-468d-8e49-266be8d7586c_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/f1f624e2-33e7-468d-8e49-266be8d7586c.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('fce2627b-648e-4486-b8f0-914b7fb5de9a', 100, 100, NULL, 'UNBOUND', 15, '2019-08-10 12:10:09', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/fce2627b-648e-4486-b8f0-914b7fb5de9a_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/fce2627b-648e-4486-b8f0-914b7fb5de9a.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('664704a8-7f94-461b-afa5-9d6261ed52b5', 100, 100, NULL, 'UNBOUND', 15, '2019-08-10 12:10:11', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/664704a8-7f94-461b-afa5-9d6261ed52b5_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/664704a8-7f94-461b-afa5-9d6261ed52b5.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('525211ea-7eea-47b3-b6a0-76374e3e7206', 100, 100, NULL, 'UNBOUND', 15, '2019-08-25 16:28:03', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/525211ea-7eea-47b3-b6a0-76374e3e7206_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/525211ea-7eea-47b3-b6a0-76374e3e7206.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('cc601e8b-6a50-4e6e-a51c-f69511cbb440', 100, 100, NULL, 'UNBOUND', 15, '2019-08-10 12:10:12', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/cc601e8b-6a50-4e6e-a51c-f69511cbb440_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/cc601e8b-6a50-4e6e-a51c-f69511cbb440.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('1a80e3a1-d2de-4725-9ed8-379b61dda5cf', 100, 100, NULL, 'UNBOUND', 15, '2019-08-25 15:58:59', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/1a80e3a1-d2de-4725-9ed8-379b61dda5cf_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/1a80e3a1-d2de-4725-9ed8-379b61dda5cf.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('e279d299-c5e4-4034-bbd6-26106f6bc85e', 100, 100, NULL, 'UNBOUND', 15, '2019-08-10 12:10:13', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/e279d299-c5e4-4034-bbd6-26106f6bc85e_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/e279d299-c5e4-4034-bbd6-26106f6bc85e.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('7eef0100-c688-491f-8e21-92429dcd499d', 100, 100, NULL, 'UNBOUND', 15, '2019-08-24 20:24:26', NULL, NULL, NULL, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('324cae49-ab6d-41be-be24-0d9d0161faa6', 100, 100, NULL, 'UNBOUND', 15, '2019-08-24 20:25:24', NULL, NULL, NULL, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('daf7fb09-8071-4569-9915-67ab2a2d23c6', 100, 100, NULL, 'UNBOUND', 15, '2019-08-24 20:25:42', NULL, NULL, NULL, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('a636975a-83ae-41fc-a9ae-2c788aec6eba', 100, 100, NULL, 'UNBOUND', 15, '2019-08-24 20:26:51', NULL, NULL, NULL, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('df03604d-b115-4bd1-8b71-c1cbda74f456', 100, 100, NULL, 'UNBOUND', 15, '2019-08-25 16:02:02', NULL, NULL, NULL, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('67bab92a-502c-4f04-b94c-cdf69cd075aa', 100, 100, NULL, 'UNBOUND', 15, '2019-08-24 20:27:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/67bab92a-502c-4f04-b94c-cdf69cd075aa_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/67bab92a-502c-4f04-b94c-cdf69cd075aa.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('eb3e1a59-a075-40bd-afdb-80be32c50ab6', 100, 100, NULL, 'UNBOUND', 15, '2019-08-25 16:03:55', NULL, NULL, NULL, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('f96072a5-9899-4cc5-af2a-30992f5dd224', 100, 100, NULL, 'UNBOUND', 15, '2019-08-25 16:04:29', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/f96072a5-9899-4cc5-af2a-30992f5dd224_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/f96072a5-9899-4cc5-af2a-30992f5dd224.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('e09d3ddb-b955-4014-a4a4-ef67d56acde3', 100, 100, NULL, 'UNBOUND', 15, '2019-08-25 16:08:46', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/e09d3ddb-b955-4014-a4a4-ef67d56acde3_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/e09d3ddb-b955-4014-a4a4-ef67d56acde3.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('df3cd351-0b5a-493a-a380-d2445b17491b', 100, 100, NULL, 'UNBOUND', 15, '2019-08-25 16:34:44', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/df3cd351-0b5a-493a-a380-d2445b17491b_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/df3cd351-0b5a-493a-a380-d2445b17491b.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'main.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('a9b51100-e899-4869-93c1-51602f452fcd', 100, 100, NULL, 'UNBOUND', 15, '2019-08-29 21:28:42', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/a9b51100-e899-4869-93c1-51602f452fcd_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/a9b51100-e899-4869-93c1-51602f452fcd.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('d787a6ea-c8e5-45f0-8359-b296f04d7e01', 100, 100, NULL, 'UNBOUND', 15, '2019-08-29 21:47:17', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/d787a6ea-c8e5-45f0-8359-b296f04d7e01_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/d787a6ea-c8e5-45f0-8359-b296f04d7e01.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('bc31b219-cc4d-42ac-bcbd-1399fa690a5b', 100, 100, NULL, 'UNBOUND', 15, '2019-08-29 21:48:54', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/bc31b219-cc4d-42ac-bcbd-1399fa690a5b_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/bc31b219-cc4d-42ac-bcbd-1399fa690a5b.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('021647eb-5cea-445d-ae92-353ca27bc302', 100, 100, NULL, 'UNBOUND', 15, '2019-08-29 21:52:42', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/021647eb-5cea-445d-ae92-353ca27bc302_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/021647eb-5cea-445d-ae92-353ca27bc302.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('55e0f630-c98e-408f-8c1e-2c01f54e235e', 100, 100, NULL, 'UNBOUND', 15, '2019-08-29 21:56:54', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/55e0f630-c98e-408f-8c1e-2c01f54e235e_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/55e0f630-c98e-408f-8c1e-2c01f54e235e.zip', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984', 'myTestJob', NULL, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('6493bccc-dc0d-46d1-856c-8f92d816d4f9', 111, 11, NULL, 'UNBOUND', 11, '2019-09-09 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/6493bccc-dc0d-46d1-856c-8f92d816d4f9_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/6493bccc-dc0d-46d1-856c-8f92d816d4f9.zip', 0, '7c39bf68-c834-4212-8cb7-fa56d6041893', 'teste', 111, 'fibonnaci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('b6d15979-3dc9-43eb-b98e-cf1bb7cd4801', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/b6d15979-3dc9-43eb-b98e-cf1bb7cd4801_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/b6d15979-3dc9-43eb-b98e-cf1bb7cd4801.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('3fa63161-1e7b-4638-8ce2-915755c0f142', 111, 11, NULL, 'UNBOUND', 11, '2019-09-09 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/3fa63161-1e7b-4638-8ce2-915755c0f142_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/3fa63161-1e7b-4638-8ce2-915755c0f142.zip', 0, '7c39bf68-c834-4212-8cb7-fa56d6041893', 'teste', 111, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('7e3a6c79-f9f4-46b8-a305-7360ed4856fa', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/7e3a6c79-f9f4-46b8-a305-7360ed4856fa_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/7e3a6c79-f9f4-46b8-a305-7360ed4856fa.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('575df88c-f865-49c4-9a32-2e7a2d0f9171', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/575df88c-f865-49c4-9a32-2e7a2d0f9171_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/575df88c-f865-49c4-9a32-2e7a2d0f9171.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('997db412-298f-45dd-8c65-15746cf6f645', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/997db412-298f-45dd-8c65-15746cf6f645_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/997db412-298f-45dd-8c65-15746cf6f645.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('e66e5635-9449-4151-bcdf-04d21b702979', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/e66e5635-9449-4151-bcdf-04d21b702979_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/e66e5635-9449-4151-bcdf-04d21b702979.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('c9a6dc6d-cd03-4790-91c0-bcaa483e392e', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/c9a6dc6d-cd03-4790-91c0-bcaa483e392e_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/c9a6dc6d-cd03-4790-91c0-bcaa483e392e.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('0c7d1aa7-1a59-403e-8ec2-fbcca1844c5f', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/0c7d1aa7-1a59-403e-8ec2-fbcca1844c5f_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/0c7d1aa7-1a59-403e-8ec2-fbcca1844c5f.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('5ca03336-b68e-41ac-ba3e-ebb7a27d51b8', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/5ca03336-b68e-41ac-ba3e-ebb7a27d51b8_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/5ca03336-b68e-41ac-ba3e-ebb7a27d51b8.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('b3fc2d3f-f028-488d-9b47-08dba433e6c5', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/b3fc2d3f-f028-488d-9b47-08dba433e6c5_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/b3fc2d3f-f028-488d-9b47-08dba433e6c5.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('e8beb369-daa4-428a-9a74-9222c5665c0c', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/e8beb369-daa4-428a-9a74-9222c5665c0c_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/e8beb369-daa4-428a-9a74-9222c5665c0c.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('bd21f4c4-57d5-4776-8d71-0aa651fe92a8', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/bd21f4c4-57d5-4776-8d71-0aa651fe92a8_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/bd21f4c4-57d5-4776-8d71-0aa651fe92a8.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('cf750402-40c5-4ee6-b1a7-96dd25bf4485', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/cf750402-40c5-4ee6-b1a7-96dd25bf4485_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/cf750402-40c5-4ee6-b1a7-96dd25bf4485.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('87c07adf-7157-44e7-a5c3-d08530f462ad', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/87c07adf-7157-44e7-a5c3-d08530f462ad_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/87c07adf-7157-44e7-a5c3-d08530f462ad.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('348669da-a0b1-4945-82d5-40dd76d9008e', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/348669da-a0b1-4945-82d5-40dd76d9008e_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/348669da-a0b1-4945-82d5-40dd76d9008e.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('0c332988-2015-47fc-8c23-4d67d50df113', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/0c332988-2015-47fc-8c23-4d67d50df113_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/0c332988-2015-47fc-8c23-4d67d50df113.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('a09dec27-033e-4402-b70d-611498a8396e', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/a09dec27-033e-4402-b70d-611498a8396e_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/a09dec27-033e-4402-b70d-611498a8396e.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('b32f9500-08c0-4801-ba27-7d54a90bb8bf', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/b32f9500-08c0-4801-ba27-7d54a90bb8bf_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/b32f9500-08c0-4801-ba27-7d54a90bb8bf.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('a4d3f051-f71a-4fff-9ce4-759b7349401e', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/a4d3f051-f71a-4fff-9ce4-759b7349401e_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/a4d3f051-f71a-4fff-9ce4-759b7349401e.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('9d789f38-284a-4283-903d-68fe2ab0ad14', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/9d789f38-284a-4283-903d-68fe2ab0ad14_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/9d789f38-284a-4283-903d-68fe2ab0ad14.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('b43674af-4495-4399-96e2-39f6dca4d746', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/b43674af-4495-4399-96e2-39f6dca4d746_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/b43674af-4495-4399-96e2-39f6dca4d746.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('f798081d-3aee-4fa5-bd2a-0bf42358c1f7', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/f798081d-3aee-4fa5-bd2a-0bf42358c1f7_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/f798081d-3aee-4fa5-bd2a-0bf42358c1f7.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('adb20051-173e-4b56-b876-0c4c40f8bdec', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/adb20051-173e-4b56-b876-0c4c40f8bdec_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/adb20051-173e-4b56-b876-0c4c40f8bdec.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('a1d4c601-5ee1-4ad5-a43f-5fb34aada109', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/a1d4c601-5ee1-4ad5-a43f-5fb34aada109_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/a1d4c601-5ee1-4ad5-a43f-5fb34aada109.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('997851c9-22c9-4824-9eae-c5cac62079cb', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/997851c9-22c9-4824-9eae-c5cac62079cb_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/997851c9-22c9-4824-9eae-c5cac62079cb.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('8af1ca22-cc1a-41b2-908b-afacafc73844', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/8af1ca22-cc1a-41b2-908b-afacafc73844_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/8af1ca22-cc1a-41b2-908b-afacafc73844.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('de1ce576-9b7a-4a12-ae6b-97f77a2614d2', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/de1ce576-9b7a-4a12-ae6b-97f77a2614d2_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/de1ce576-9b7a-4a12-ae6b-97f77a2614d2.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('e6c63859-e5a4-495d-8c49-a7cedc0536e7', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/e6c63859-e5a4-495d-8c49-a7cedc0536e7_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/e6c63859-e5a4-495d-8c49-a7cedc0536e7.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('7e06836c-bada-4e90-9833-1849422a1637', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/7e06836c-bada-4e90-9833-1849422a1637_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/7e06836c-bada-4e90-9833-1849422a1637.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('b7cbc125-e363-4321-aab4-a1c25797c66a', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/b7cbc125-e363-4321-aab4-a1c25797c66a_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/b7cbc125-e363-4321-aab4-a1c25797c66a.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('d9764614-f959-484f-8076-19fdafc3d9ff', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/d9764614-f959-484f-8076-19fdafc3d9ff_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/d9764614-f959-484f-8076-19fdafc3d9ff.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('057deef2-d741-4fe0-9c67-278f1a3e532c', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/057deef2-d741-4fe0-9c67-278f1a3e532c_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/057deef2-d741-4fe0-9c67-278f1a3e532c.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('870a690a-a2c4-4ae0-b846-2f945d67c384', 0, 0, NULL, 'UNBOUND', 1000, '2019-08-08 15:15:15', NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/870a690a-a2c4-4ae0-b846-2f945d67c384_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/870a690a-a2c4-4ae0-b846-2f945d67c384.zip', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319', 'my_test_partial', 0, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('fb652612-f6ca-4911-bde0-3984c055e91d', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/fb652612-f6ca-4911-bde0-3984c055e91d_input.RData', NULL, 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('960d20a9-eed0-4283-894c-7df58120f2f6', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/960d20a9-eed0-4283-894c-7df58120f2f6_input.RData', NULL, 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('47c28f82-d976-4ddd-a0f8-318452031e9e', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/47c28f82-d976-4ddd-a0f8-318452031e9e_input.RData', NULL, 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('40c7fb1a-924c-4958-8082-31d41d0931ac', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/40c7fb1a-924c-4958-8082-31d41d0931ac_input.RData', NULL, 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('a7eda85c-bf6e-49f3-a2a8-d811a7a3371b', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/a7eda85c-bf6e-49f3-a2a8-d811a7a3371b_input.RData', NULL, 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('2bd96565-b516-4dd5-adab-1e5331ed46f8', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, NULL, NULL, 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('6df556bf-6fb1-400a-9292-6e1214fb25bb', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/6df556bf-6fb1-400a-9292-6e1214fb25bb_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/6df556bf-6fb1-400a-9292-6e1214fb25bb.zip', 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('a7ff1885-2f07-4172-bc5f-96c085fd0600', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/a7ff1885-2f07-4172-bc5f-96c085fd0600_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/a7ff1885-2f07-4172-bc5f-96c085fd0600.zip', 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('c0aaa963-de6f-4979-b3c6-7e8755b54422', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/c0aaa963-de6f-4979-b3c6-7e8755b54422_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/c0aaa963-de6f-4979-b3c6-7e8755b54422.zip', 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('e03a1566-9a78-4fb2-b0fa-fd5566669ced', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/e03a1566-9a78-4fb2-b0fa-fd5566669ced_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/e03a1566-9a78-4fb2-b0fa-fd5566669ced.zip', 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('097252c9-c104-49b4-8b98-a791fc87981e', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/097252c9-c104-49b4-8b98-a791fc87981e_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/097252c9-c104-49b4-8b98-a791fc87981e.zip', 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('249d8d91-2c1e-42c8-b7ba-d27ba31d7185', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/249d8d91-2c1e-42c8-b7ba-d27ba31d7185_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/249d8d91-2c1e-42c8-b7ba-d27ba31d7185.zip', 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('fef154d7-10e3-456c-a332-4b10555882fa', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/fef154d7-10e3-456c-a332-4b10555882fa_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/fef154d7-10e3-456c-a332-4b10555882fa.zip', 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('92655612-ce5e-44d1-a16c-667d12d4e4fd', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/92655612-ce5e-44d1-a16c-667d12d4e4fd_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/92655612-ce5e-44d1-a16c-667d12d4e4fd.zip', 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('4bc9c05e-c964-4bd0-a5e1-a6e56f73f721', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/4bc9c05e-c964-4bd0-a5e1-a6e56f73f721_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/4bc9c05e-c964-4bd0-a5e1-a6e56f73f721.zip', 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('e8e86b76-e896-4c30-b838-40396eb6eece', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/e8e86b76-e896-4c30-b838-40396eb6eece_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/e8e86b76-e896-4c30-b838-40396eb6eece.zip', 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('9c1a0e81-8cfd-4972-8dff-f3c67231c79b', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/9c1a0e81-8cfd-4972-8dff-f3c67231c79b_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/9c1a0e81-8cfd-4972-8dff-f3c67231c79b.zip', 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('7d7df989-e757-413c-88d2-859242613f55', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/7d7df989-e757-413c-88d2-859242613f55_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/7d7df989-e757-413c-88d2-859242613f55.zip', 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('3561d048-46c5-4ef4-845e-defac3815006', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/3561d048-46c5-4ef4-845e-defac3815006_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/3561d048-46c5-4ef4-845e-defac3815006.zip', 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', '["fibvals", "i"]');
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('98be33f4-82d6-408b-8abc-c7e30ae1fe5b', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/98be33f4-82d6-408b-8abc-c7e30ae1fe5b_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/98be33f4-82d6-408b-8abc-c7e30ae1fe5b.zip', 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('1eb7bfd5-1948-4085-bf87-c4b46b4a0b33', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/1eb7bfd5-1948-4085-bf87-c4b46b4a0b33_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/1eb7bfd5-1948-4085-bf87-c4b46b4a0b33.zip', 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('02f4d970-8842-4a6f-8016-333405466244', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/02f4d970-8842-4a6f-8016-333405466244_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/02f4d970-8842-4a6f-8016-333405466244.zip', 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('d3c8767d-dfe0-4457-83c0-29d78be0e45f', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/d3c8767d-dfe0-4457-83c0-29d78be0e45f_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/d3c8767d-dfe0-4457-83c0-29d78be0e45f.zip', 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', '["fibvals", "i"]');
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('776ba279-1914-46be-bf08-2bddff113ede', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/776ba279-1914-46be-bf08-2bddff113ede_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/776ba279-1914-46be-bf08-2bddff113ede.zip', 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('b35cd34a-e9cc-4be6-8028-7d44e3e975d4', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/b35cd34a-e9cc-4be6-8028-7d44e3e975d4_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/b35cd34a-e9cc-4be6-8028-7d44e3e975d4.zip', 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('e9d36b02-1dbb-492f-a84d-7c5d02367a48', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/e9d36b02-1dbb-492f-a84d-7c5d02367a48_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/e9d36b02-1dbb-492f-a84d-7c5d02367a48.zip', 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', NULL);
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('e039f7c6-edba-4758-8806-e72f53720176', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/e039f7c6-edba-4758-8806-e72f53720176_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/e039f7c6-edba-4758-8806-e72f53720176.zip', 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', '["fibvals", "i"]');
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('f18cf366-0bd9-47ca-8c7e-c946b2ca00b4', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/f18cf366-0bd9-47ca-8c7e-c946b2ca00b4_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/f18cf366-0bd9-47ca-8c7e-c946b2ca00b4.zip', 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', '["fibvals", "i"]');
INSERT INTO public."Job" (id, disc, "RAM", exec_time, status, price, deadline, init_time, r_data_path, folder_path, mean_up_time, user_id, name, "CPU", exec_file, "partialResultsVars") VALUES ('28bc837f-9ca7-4968-b444-61918ddd3ba9', 100, 100, NULL, 'UNBOUND', 110, NULL, NULL, 'C:\Users\Tiago\Documents\P2P-VC-Market/files/data/28bc837f-9ca7-4968-b444-61918ddd3ba9_input.RData', 'C:\Users\Tiago\Documents\P2P-VC-Market/files/code/28bc837f-9ca7-4968-b444-61918ddd3ba9.zip', 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56', 'partialResultTest', 100, 'fibonacci.R', '["fibvals", "i"]');


--
-- Data for Name: Machine; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Machine" (id, name, "CPU", disc, "RAM", price, scj, credibility, user_id) VALUES ('2dd34e15-27ce-44f0-aa7a-1c6e6deea987', 'test', 1, 1400000, 2, 15, 1, 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319');
INSERT INTO public."Machine" (id, name, "CPU", disc, "RAM", price, scj, credibility, user_id) VALUES ('20a0b349-03fb-48a9-8775-58395c2d8da5', 'test', 1, 1400000, 2, 15, 1, 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319');
INSERT INTO public."Machine" (id, name, "CPU", disc, "RAM", price, scj, credibility, user_id) VALUES ('8f922414-d107-4f00-a50d-ac4c50f20d88', 'myTestMachine', 1, 1500, 1500, 10, 0, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984');
INSERT INTO public."Machine" (id, name, "CPU", disc, "RAM", price, scj, credibility, user_id) VALUES ('82ec7965-78b1-4704-9af7-2884b83d35fb', 'myTestMachine', 1, 1500, 1500, 10, 0, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984');
INSERT INTO public."Machine" (id, name, "CPU", disc, "RAM", price, scj, credibility, user_id) VALUES ('4ca472c2-eb0a-4559-9be6-6d1339ab45ff', 'myTestMachine', 1, 1500, 1500, 10, 0, 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984');
INSERT INTO public."Machine" (id, name, "CPU", disc, "RAM", price, scj, credibility, user_id) VALUES ('f796f16f-fc43-4016-aa96-f27af7bb7c98', 'teste', 132, 121, 1212, 12, 0, 0, '7c39bf68-c834-4212-8cb7-fa56d6041893');
INSERT INTO public."Machine" (id, name, "CPU", disc, "RAM", price, scj, credibility, user_id) VALUES ('e0f9aaca-53c3-4039-826e-a999a844fe6f', 'd', 100000, 100000000, 100000, 1, 0, 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56');
INSERT INTO public."Machine" (id, name, "CPU", disc, "RAM", price, scj, credibility, user_id) VALUES ('45692db4-c1ef-4be1-b151-f68810907a7b', 'machine1', 140000000, 140000000, 140000000, 1, 0, 0, '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Machine" (id, name, "CPU", disc, "RAM", price, scj, credibility, user_id) VALUES ('4781a80c-b298-4317-b299-e113362f9b67', 'machine2', 140000000, 140000000, 140000000, 1, 0, 0, '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Machine" (id, name, "CPU", disc, "RAM", price, scj, credibility, user_id) VALUES ('148e125d-5934-4f5e-b17a-fe1587a57427', 'machine3', 140000000, 140000000, 140000000, 1, 0, 0, '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Machine" (id, name, "CPU", disc, "RAM", price, scj, credibility, user_id) VALUES ('8f24fb90-24c1-4cd8-a31b-ddefb3d7937a', 'machine4', 140000000, 140000000, 140000000, 1, 0, 0, '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Machine" (id, name, "CPU", disc, "RAM", price, scj, credibility, user_id) VALUES ('4db49ed0-3a70-4b1a-8af1-7936f26729bc', 'machine5', 140000000, 140000000, 140000000, 1, 0, 0, '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Machine" (id, name, "CPU", disc, "RAM", price, scj, credibility, user_id) VALUES ('e324f4d3-5a06-4224-b066-f5e5390a8be5', 'machine5', 140000000, 140000000, 140000000, 1, 0, 0, '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Machine" (id, name, "CPU", disc, "RAM", price, scj, credibility, user_id) VALUES ('297a3248-499f-453f-9391-d5dded0ae790', 'machine6', 140000000, 140000000, 140000000, 1, 0, 0, '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Machine" (id, name, "CPU", disc, "RAM", price, scj, credibility, user_id) VALUES ('f84dcd9f-fd0f-43e9-9f4b-8042b4b7f0af', 'machine7', 140000000, 140000000, 140000000, 1, 0, 0, '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Machine" (id, name, "CPU", disc, "RAM", price, scj, credibility, user_id) VALUES ('a5ce847a-5405-4260-966c-3faa54456fbf', 'machine8', 140000000, 140000000, 140000000, 1, 0, 0, '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Machine" (id, name, "CPU", disc, "RAM", price, scj, credibility, user_id) VALUES ('e2815a90-d30d-4b39-a365-e92a2514eabe', 'machine9', 140000000, 140000000, 140000000, 1, 0, 0, '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Machine" (id, name, "CPU", disc, "RAM", price, scj, credibility, user_id) VALUES ('0c3e4b0a-f6e5-4434-a701-5bca6e7fd342', 'machine10', 140000000, 140000000, 140000000, 1, 0, 0, '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Machine" (id, name, "CPU", disc, "RAM", price, scj, credibility, user_id) VALUES ('63f53e57-8c58-4d36-bc50-b41d145de0cc', 'machine11', 140000000, 140000000, 140000000, 1, 0, 0, '4a78f729-ef25-4e03-876e-8fecd7893513');


--
-- Data for Name: Token; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('775eb8af-e297-4937-9d68-1feb8b6a1e14', false, 'user', 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('9e027061-6743-4d14-9e47-cf73ec82e8c5', false, 'user', 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('27dd0997-f542-442f-b5cb-fbd6a563883c', false, 'user', 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('5aa98924-4a5b-42ae-b3b3-7d9ab2fe1b67', false, 'user', 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('a7ab4c48-03ea-4ed5-93a4-164b50d0487f', false, 'user', 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('4b538515-34ec-48e7-860c-039d3a5a8fd7', false, 'user', 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('79687ca7-70f4-4794-979d-08b81d29728d', false, 'user', 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('14d0b609-52d9-482a-bd1b-0760041e19af', false, 'user', 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('cf10fe2f-a465-4365-b5d0-e625cfa3ad87', false, 'user', 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('015eee93-50ff-4f53-ba27-6daef7a60df6', true, 'user', 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('b908b9b8-7b54-4dbb-be78-4c56323cbea2', false, 'user', 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('fd972af0-e8f8-4e02-9301-d16e2dd4ebd0', false, 'user', 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('3ece8325-8774-4f75-8deb-c99d60ebdf96', false, 'user', 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('cb133a40-cb28-4690-b66b-10dcaf434fb7', false, 'user', 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('0ebf074e-3fbd-43fb-bf41-95202b8d5dc3', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('fc446939-9f51-43eb-a77c-3dc51c919111', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('9773ec43-87d2-4d4e-b90a-8a90003651ba', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('ddec67cd-3527-446f-9e7d-70cad330c6ef', false, 'user', 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('bc62417e-fe5c-4501-b4ee-4d617b1a9801', false, 'user', 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('ea51fe89-0b73-45b5-b09f-7aecaa10c0b5', false, 'user', 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('de2d17a3-5bc9-481b-b40c-12c574d76ac7', true, 'user', 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('e85012a5-e9c2-4805-858b-80f5501211d3', true, 'user', 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('a190a88d-f1b4-46a1-80e9-fab1a7efaf65', true, 'user', 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('da6daa91-a8ba-49e7-9679-93bbcbca57d1', false, 'user', 'ee7f2883-46df-41f3-bfcf-0f730e7fc984');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('47b144fa-e496-4171-911f-8d089d3c351d', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('e7bbbbda-a12a-403e-bdce-5caeae6cd685', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('c7b0c9ad-dedb-4fce-afc6-72b9b7d48847', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('f1856cc3-20e0-4780-b02a-da5a0b055d6b', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('6e1da60d-6a76-4aaf-b87c-1457e5fc75e9', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('71bcb8fb-a898-4a8f-9119-b46f281bec07', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('7c6ae200-d867-4aa2-ba21-af71d28b7b36', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('c9a62050-97c4-413b-9850-f6096dc8e5aa', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('f7145877-8a44-45f8-bd9b-34fbe3ea552f', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('4ab1100f-9a55-44d2-9614-35111abdf21e', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('f0d23fcb-ce45-4711-90c7-729b81eda190', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('503c743f-a0a9-4c84-ae0d-d8d895430dfe', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('4a55c366-a823-44ac-9423-76cd18e63cfe', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('3dfcfea1-1a96-445e-b27c-357cdc89b09e', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('b4531279-65f5-4ab0-b760-875866b47cf9', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('ea0fb1ec-39c9-4d18-af41-32e6e309b083', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('00dc5f8e-e919-4f34-bad6-c153f781dd19', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('8a21a727-4f80-4a0b-858a-46a25b56f597', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('637eeaa5-a3f9-4e11-835a-932f7b0f6c0e', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('38b5f251-4c30-45e1-9fe4-01725d42e766', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('9f5ddca9-dadc-4c5a-ab4f-4da12adc162b', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('d5a87d1f-6862-4ae6-b81d-471e32752d97', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('5243940c-ec8c-49f5-8982-d8dc0e4f13f1', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('c7b86ee6-fee6-4875-bc49-5fd9e5631eb0', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('664df0a7-fd7e-4e6e-b733-3d3416f7f4c5', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('52631ded-079a-4915-8691-c930128d8611', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('5837f863-238d-40d6-835d-4737ca107393', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('766d3c4f-8314-4247-ab0b-448eb013abcb', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('e7c43d5b-8a81-4a28-baf2-5137486ddca3', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('53051644-c74d-4243-a88e-7c899ff6fc31', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('c3671294-cf2b-49d9-9fb3-f506e1bf0cf3', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('7d0d9e08-8f00-4a02-b162-3aba0482d8f3', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('5ebbd1dc-21af-4885-a015-8af9c17ff15c', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('01b22c6d-02e2-4935-b3da-5c58d6a157ee', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('605c7b28-e17e-4d2f-bf27-cc4dba266893', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('4cf13550-fe16-4356-92e1-5900aa741243', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('b7e24c31-6b19-4c13-9e72-37f311e38981', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('66cd994b-732d-46b8-8aaf-942d84daf1e9', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('348f6d2c-ac72-455b-aa90-9fdec4ba49c1', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('945bf89c-f9ce-4e86-8385-18e3cc93279b', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('8a3b5f86-7a01-4b16-8c32-b60e3f3bf374', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('5b728537-dc94-40ec-91aa-5ec545793599', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('342f1fad-74bc-4e9d-8b6d-c220b9780101', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('93eb59f0-a598-48a2-ac5d-074133ef9adb', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('53b6f152-ceeb-4eb3-902c-a9f287456c92', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('61ba4c85-8301-4b17-b07c-d008d6d97c06', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('f544c1a2-5528-4ee8-b738-78947ca30dcc', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('6d3f142f-0a11-47d5-b888-d044773f702f', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('8048b8e4-4860-410d-bf2c-5cdb1dd76d12', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('130c2dd7-b722-4af0-b120-2487433204d2', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('5f71fb3d-5cc3-4c90-b91b-2c97c6d224f0', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('a0795c55-561d-411c-9be0-ac7f78872322', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('0273f5ce-8deb-44b0-9ea9-c05aeb40edcb', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('05fbb125-cf4e-463d-9bd4-5bd17d87ba51', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('5abea6f3-2146-4206-a895-7df58d21a939', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('31e07ca3-6b1c-4214-839c-b85c7c14b42f', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('ae36b0e0-c76c-4072-a1dc-951519d347b2', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('b48a77a1-fccd-4c01-933d-8ba19fd0f548', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('ce09b750-55e9-4e91-9537-e89fdae61890', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('d6c84f9c-2ddf-4ef9-b37c-d7456fd89294', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('4486b834-abb0-4de7-9cc9-b509ed2fa8bd', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('ecf2312d-13b4-4ff8-bcc3-66712d964168', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('58b2a3b3-645d-452f-9d1e-b4588a4bcd61', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('35508fa6-afab-4de2-9c64-d024c0445e11', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('d0d4d42e-0f76-4299-8c7b-53463b930b3c', false, 'volunteer', '8f922414-d107-4f00-a50d-ac4c50f20d88');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('08d864f2-77f8-432f-8a8d-0f1a461eabcd', false, 'volunteer', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('d27c1590-e814-40cb-a026-57dfd336e0d5', false, 'volunteer', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('2e52cf82-a8b5-4165-bb8d-db56a8bdeabc', false, 'volunteer', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('c61f41b6-bf31-4f14-8849-e15c37eaf84e', false, 'volunteer', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('cad772ba-f53d-4117-ae4a-77b0b0d49d2b', false, 'volunteer', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('09e7d00f-a57d-4d75-ba4b-06ac79b32ae2', false, 'volunteer', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('9aed2419-edbb-491f-9d0a-78c730144919', false, 'volunteer', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('ae511bbd-4564-4129-8ba9-eca848d5f2d5', false, 'volunteer', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('7f464104-645d-48d9-a37f-5b389c64d8df', false, 'volunteer', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('f75ffe54-1fff-48e3-aa0d-5ee974e41596', false, 'volunteer', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('745b2c35-7447-4153-b6ce-5e4cd2890c1e', false, 'volunteer', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('a63d36c0-81f0-4d4c-b8f7-3a16ec263e9c', false, 'volunteer', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('a841d382-7410-4e92-b841-a6587cf5908d', false, 'volunteer', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('d60447f5-3f66-45bd-ab6b-24f1e3009053', false, 'user', '7c39bf68-c834-4212-8cb7-fa56d6041893');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('545c37fe-b25d-4cd9-8927-67c6069059d2', false, 'volunteer', 'f796f16f-fc43-4016-aa96-f27af7bb7c98');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('bb48c49c-c57c-43e8-b2ae-a033c956ad3c', false, 'volunteer', 'f796f16f-fc43-4016-aa96-f27af7bb7c98');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('5cf3c6ae-fc85-4eab-a164-c13d9bf35815', false, 'user', 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('3ec5b514-484e-4f85-898e-233d8ba47ff9', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('e5254c88-c4a6-4487-8859-cfc8a3e11b4a', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('c1c94961-119b-433c-8ba0-9a121c46ca7b', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('e1212b82-be8b-4267-a03b-a4b2a83e4b80', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('58ca300f-01a1-45f7-81ef-0ee0cecb76de', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('53bf254a-d06d-46a1-8972-3d77106cdc01', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('6085d8c3-83e7-48b4-a228-d7c6377b4410', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('6ab453bb-0f2f-48d6-906d-bd279a7d1918', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('bf03bdbf-5c21-4cfe-807e-6364df76426a', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('a5b483fd-f734-48af-a008-2847ae4cbb6b', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('73a89453-6c98-4d43-8732-68ffb38dab78', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('9bd1ed60-80a4-40d7-bc47-0ca498f9433c', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('058e6a60-85b2-41a7-bb85-a192c477568f', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('c2d4b1f9-86a5-4d7e-b29a-cad63d4bfad7', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('eb8fa64b-e14e-41ef-89b0-19e54a53931b', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('b0578d12-ad1d-4b49-baa7-2901cf766731', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('472c3cc7-581d-404f-84ce-39aad1931fb2', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('74acf245-f8fe-4b1c-8b27-7ae28eca1f36', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('c4f931eb-9fb6-4525-8cec-64fed28f91ef', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('cf5d8a0d-3e9b-4caa-aa32-01b748d1104b', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('447c47e8-100f-47ea-ba8f-71126423bf37', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('2ed91ef8-d13f-4e1d-a307-4209364011f8', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('101d2457-bd1e-4fdf-8725-1983a23d7770', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('dfad9611-0cc5-4179-84c8-0b26b9342ae5', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('b9cbb7cd-4550-4131-8a52-8ac2d2fb6ebf', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('d777a718-95d5-4294-8e07-ed28e3c4ee63', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('ef3d0106-84db-4979-89f0-4146ddb74391', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('21c876b2-2164-4d51-8d6a-e8716184d6d5', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('b722813d-8793-4a42-877b-b225bbb4604e', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('8561a35f-d99c-43a9-8679-343f5ff42dba', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('189d0368-aefa-45cc-ab19-7648be08f6e0', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('9efdd88a-948b-4677-bd44-ef1f0ed340ce', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('7f10e89c-35a5-4ee1-98ce-7aee399ae85e', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('74b73f40-f246-4069-868b-70f0b35560a0', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('ebe0c9d8-294e-42d3-8f03-f20a0d2c3a07', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('01b49286-9fba-4d98-9d0c-0c9ee9a7b46a', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('aa46ec67-ca00-4092-9e33-3ca5f864d229', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('90418f61-1bbd-462c-afb7-d19f5e2e80d1', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('8575d29f-d60a-45d3-9ec9-3ba52b4f5ce7', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('df4fb4d7-8938-4b77-8e72-462e967e7a76', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('743d460e-1369-424f-9c24-5e0aeb08fe28', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('08ea89cc-3482-4fc9-9ce8-b9b681cfa447', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('f157a5c1-3e60-4283-8f64-35d59a5efd44', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('67c97a6e-9918-44ea-85a0-3bf1d03af070', false, 'volunteer', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('516ca527-c004-4082-91ac-3686ed9d1a17', false, 'user', '94d3db0f-3ee7-42cb-809f-1d083a302b56');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('77a3a804-c29d-4022-b05c-08fcf2a0a8f0', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('339b9752-b27e-48ee-a64c-c4a77f43fcdc', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('2aeecf54-bc71-45e7-9e39-db345ea9f2a1', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('ff3e3a6a-3b1b-4a63-a8aa-eef0c138a504', false, 'user', '94d3db0f-3ee7-42cb-809f-1d083a302b56');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('e4b801b4-8604-4e96-8a4f-7a6051ebf0b6', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('36505d52-4b57-4cc2-87a5-e88619e001b8', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('ac709ec3-2f1c-413a-a98e-308aabe4929c', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('340b45e0-169e-48ef-bf39-8c93149cb0e9', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('69460182-2100-4568-867a-b317db1a5f6e', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('e31c459a-d9fe-456c-b83f-200f5c293ef9', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('efd7a28d-c1a7-4868-85d2-835797065a51', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('ccfd68a6-acdb-4953-89c4-e0bfff0b0e25', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('c9d1a18a-e412-4dbb-a886-3b483707e11e', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('c723921b-e630-4163-8e55-c91922d49817', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('0063f005-e8c3-4b39-9c98-ffffd499e2fc', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('29c9ba5a-84e4-480e-bcd6-0df948b5a4c4', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('a6c981bd-7c26-4692-a6ea-ef1bb4963567', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('7afdaf4c-4147-46ce-903c-c6a80c499ad4', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('2d09962d-8d2d-4506-81e6-8b25f20d2eb3', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('24487dfe-219d-498b-baa9-aecc1d13526a', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('62d2e90a-2f46-441c-97d0-222fc5f3ce6b', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('98a2bd08-bcaf-4351-8c7f-03c207fa57f7', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('01ea5c2c-d4ca-4032-9b70-2f7ef45a5821', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('c1c07d57-1298-43bc-94ff-66d5f1815db1', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('26cb9435-db7f-4e5d-afdd-97501052bf54', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('fcbb6a63-f623-4335-8135-aa14d4437aa5', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('512ec685-c58d-4f01-8835-43828c783912', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('94fa8a85-96c6-4b44-8d17-76501c861c89', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('a5b9b54d-1edd-4260-b9c3-7a2e699da407', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('87bb177f-112c-433d-92a3-1c1ff7542708', false, 'volunteer', 'e0f9aaca-53c3-4039-826e-a999a844fe6f');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('e7030176-17c8-461e-a42a-34e47be0192a', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('334c82da-318b-4c10-8217-fb4fc17e214a', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('9274e5a4-1a9c-455c-ba1b-1c1d6b6f7ade', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('1506ada5-2461-4e8f-a81b-77079852cfeb', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('7752f260-9a65-4ffa-ae43-282d2144c89b', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('ecfdbc34-8522-4926-95ea-1350537c944a', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('963dde9b-2b1b-4340-8b22-dd9bc2b0867c', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('15b13e69-9d61-4350-9230-2766a3a42f69', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('19047c33-34de-44a5-8f46-b2f4bc51120f', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('117e95fa-52c0-4178-be58-5e166a6ae965', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('26662e8f-db79-4478-8066-b83acb8cd3ad', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('35ab03dd-c11f-4ce5-b9ec-4aade3b477c8', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('a78e0854-019e-4585-92cb-b1110357d839', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('c5c8d46d-fa68-4b19-83df-4fdaae3234af', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('b21bd54e-90d2-4767-a2cc-01990b0d4e57', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('abe0da58-eaa6-4ec1-9c9d-5d566b1e9a43', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('74eb625b-2bfa-4c2c-8b91-813d391f8b54', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('619ed718-3e6b-47aa-bcfd-e9617290b588', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('27d1a1c5-8c4b-4a0e-9ae4-1ee990aad9f3', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('2136173c-3e47-44aa-8270-04d573165bd9', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('62c8a18b-f5e7-4b5f-b0f5-6b7899432d29', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('50a8afbb-118c-4042-8202-c9485c7f149d', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('1fdd23d3-d0d5-49e6-80a0-aedfb8e899f2', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('a03922bf-1302-4768-96ae-1ed5e4501010', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('cdedc250-eb60-45e6-85c8-9f3b40cce789', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('69d2c3cb-c7b5-461e-8443-a2626a831080', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('f91d11b6-8706-466b-af70-a34b9940d5ad', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('a8c3b63a-036e-41cf-a1c1-2bbda8471abc', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('61974854-e130-43ac-9646-54ceddf3aa37', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('71725ad4-d6a0-4bc8-b817-a24650b30285', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('0d581634-5903-4871-bb2d-cde7af9046bc', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('82375561-9942-4039-9539-a9312936c3ba', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('b44bd22d-d729-4f38-9124-ea6e08546bdf', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('11c41fb9-edc1-442c-8205-856dd00457d5', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('bcfdc0dd-2156-490f-8d84-04a160ec5631', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('50941245-a992-43ea-a083-e284bd823fb1', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('3673e9f7-b36b-4adb-bfdd-ce8ec11c0797', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('6ecf0742-2f33-46d8-b229-1fb80caaa988', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('b287f623-866a-4da1-a174-9b3b32cf2f20', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('5a47a22f-50b1-4f2d-9a20-95fec1161da7', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('84fae6a4-7647-4e4d-b71d-86178a036614', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('47e55df1-d67d-4902-b9e2-37efe8cb09bb', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('2cc4c602-98ce-4079-bb25-298c5f144aaf', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('431a0520-adf2-48da-bc27-076e30a62187', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('4de67233-05da-4869-b364-0751d1ab4c15', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('32b1e8f2-96f9-4fad-ad23-05cd0ffad8f0', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('5ea007dd-2276-4c7e-ba21-8c5365265812', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('1b6f68df-bae0-4065-972c-4c3a5f751c2e', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('434dd1e8-052f-4ca6-b446-698d3a9c726a', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('51158cae-aa73-4a1d-aaf3-b653d4aa42e5', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('9dfc2b7c-7f81-4aa5-95ba-3373969ee59d', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('10a61608-ae87-4742-a358-70860ec3943e', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('a2d5f7bf-b91a-44eb-9b10-9cdd85d10fe7', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('c1065dc1-43ad-43ef-8265-5dc36b37e2d0', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('142a3602-82b6-4cba-8c62-48a6d1f76e63', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('8785343f-6ce4-4915-b377-3a6ca91d23dc', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('12c0dfb4-96a5-4b10-9900-7ec76c763ac8', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('fba3d148-3b7e-4487-aa47-863648cef60d', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('f4c6ed6f-42d6-4208-a1b6-5f17a88f765f', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('266dc3f3-4269-43d8-a0ee-34b94e628d03', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('2a9679c6-c303-4e27-91e9-82c56e24dfbf', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('e792d3a5-62b6-4975-bf2a-dc226b3b07cc', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('dbe29500-9ddd-4197-8c09-f24dac6f371c', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('269255ba-afad-4875-a82a-39f35200ac51', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('1db7f32e-7564-405c-a7cd-b11558dafcbf', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('45941e39-4155-479a-8320-fa391dd97790', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('57c60a48-7daf-4c4f-aaa6-0980beafbbec', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('4ce13fb6-352c-43a2-a80a-1270e3b8f66f', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('abfd3e8e-f583-485a-926b-b419efed47bb', false, 'volunteer', '63f53e57-8c58-4d36-bc50-b41d145de0cc');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('369afa58-a65c-4390-b37a-a1ec6defb4ea', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('b85df120-e90d-43d0-ada8-6652c7aa4e15', false, 'volunteer', '45692db4-c1ef-4be1-b151-f68810907a7b');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('b560cd69-a2f6-4dbb-a099-d3bd3a5ed2ba', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('be963743-a0ef-4299-b9de-33e1c3d8e2df', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('e873af00-41c7-4871-b8ef-bdeb505dc729', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('11854148-8a92-4f33-b5a5-ff2438b99bcd', false, 'volunteer', '45692db4-c1ef-4be1-b151-f68810907a7b');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('6b10b6cf-8b58-430d-8a4e-2f9d60afab4f', false, 'volunteer', '45692db4-c1ef-4be1-b151-f68810907a7b');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('0cedc62f-3cc8-4ea3-8d53-465dbd0797fb', false, 'volunteer', '45692db4-c1ef-4be1-b151-f68810907a7b');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('633c5914-9e7e-4a55-9374-3f265fc5d7ec', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('71de8baf-3190-4afd-b344-276e75dfa43c', false, 'volunteer', '4781a80c-b298-4317-b299-e113362f9b67');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('9d615955-4adb-4eb2-aaee-787724f506ea', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('9319ccd9-c6b6-4ffa-9cbe-d1f08d31a4b7', false, 'volunteer', '148e125d-5934-4f5e-b17a-fe1587a57427');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('a3e39613-7cd3-4b22-978f-3aa9fe9626f7', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('bda7d0aa-7864-4f6f-919e-9b8b0e14cdbd', false, 'volunteer', '8f24fb90-24c1-4cd8-a31b-ddefb3d7937a');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('89123017-5a77-4202-8252-737b289f97e4', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('96906413-952f-4ecb-9950-8b61143aac5b', false, 'volunteer', '4db49ed0-3a70-4b1a-8af1-7936f26729bc');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('80b39a7f-e583-4856-bc6e-d7353cff06db', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('6f035a70-ef3b-482f-a3e3-4f98519b22de', false, 'volunteer', '297a3248-499f-453f-9391-d5dded0ae790');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('af793ad8-3ed4-4c58-9ac5-a23090e89912', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('96b72562-fec2-40ce-a65a-82c08ffff205', false, 'volunteer', 'f84dcd9f-fd0f-43e9-9f4b-8042b4b7f0af');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('31c1f1d2-030b-4ff4-91b0-76f48f165355', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('4a992ec9-11d1-45d8-b1bd-9b53e93d136a', false, 'volunteer', '45692db4-c1ef-4be1-b151-f68810907a7b');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('cd876445-614d-4cf5-8703-555a447d16d6', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('7c1bb4f3-d830-4f05-b564-9f4976ef5f0f', false, 'volunteer', '4781a80c-b298-4317-b299-e113362f9b67');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('04382bf2-7a7b-4dc8-9658-8e1bd8fd99c7', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('ce30b760-b49b-4224-a6ef-5b05f680918e', false, 'volunteer', '148e125d-5934-4f5e-b17a-fe1587a57427');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('2d92a538-5648-4727-8714-e7b3fca6801a', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('662884c2-e2be-4d9f-8c24-6896c055cbb1', false, 'volunteer', '8f24fb90-24c1-4cd8-a31b-ddefb3d7937a');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('1a66b422-acab-4450-b20b-4885f4ee6866', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('e2023938-ce03-4bfa-9c03-bcf730f70895', false, 'volunteer', '4db49ed0-3a70-4b1a-8af1-7936f26729bc');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('f437ebf4-45d2-474b-bd9d-31b7f95025e4', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('c66e9c0c-d69c-426e-8783-05b607364d4e', false, 'volunteer', '297a3248-499f-453f-9391-d5dded0ae790');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('6ae97450-2e17-4a07-af4d-f8a942ec0336', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('043a5adc-e44f-4e9a-bf7d-bd184ae6fa10', false, 'volunteer', 'f84dcd9f-fd0f-43e9-9f4b-8042b4b7f0af');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('262d5174-2fda-4470-9fc8-f9b060b3beae', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('ef52c486-3a6e-47b6-8d7b-53ce9398af70', false, 'volunteer', 'a5ce847a-5405-4260-966c-3faa54456fbf');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('2a9071b8-91b8-4c8d-a804-d0bbb1ab3e0a', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('7d46827e-9278-416a-ae45-44d1f28debad', false, 'volunteer', '45692db4-c1ef-4be1-b151-f68810907a7b');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('4b9ede06-0140-4fd9-9e02-feeec2604588', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('560c9847-8571-43f6-93ad-089a4c87c7b6', false, 'volunteer', '45692db4-c1ef-4be1-b151-f68810907a7b');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('a00ccafd-2a2f-4db4-b990-a1c13ee36a45', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('058332cf-95e9-4e59-97c1-3ed767aaecf4', false, 'volunteer', '4781a80c-b298-4317-b299-e113362f9b67');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('7f689c94-e783-4013-a39f-b6cd78aa3db9', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('32bed62b-0d66-44f4-9092-6a586fd248a1', false, 'volunteer', '4781a80c-b298-4317-b299-e113362f9b67');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('56682032-ed40-4a33-b2cb-eded96e0d778', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('72b73076-3e2b-4711-9f6f-0a9ee58cba63', false, 'volunteer', '45692db4-c1ef-4be1-b151-f68810907a7b');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('8d4345ed-7cef-4c68-a537-04a13799545b', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('a80efad9-cb19-4b9d-a28d-23c4e7596f8f', false, 'volunteer', '45692db4-c1ef-4be1-b151-f68810907a7b');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('7941142b-e888-4641-a5d8-1b3ee28af46a', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('0206883c-b3d7-45ca-bb1a-bdea878dd657', false, 'volunteer', '45692db4-c1ef-4be1-b151-f68810907a7b');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('6b4cd446-77ed-4a62-b3dc-9950b22dd8e0', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('53bbd2fb-d059-48bf-804d-444c84818007', false, 'volunteer', '45692db4-c1ef-4be1-b151-f68810907a7b');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('b2855fcd-7feb-4980-851a-ad449be7d447', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('11bfebeb-c8d3-45b2-9844-4f51ea8e69a2', false, 'volunteer', '45692db4-c1ef-4be1-b151-f68810907a7b');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('f1ff55c7-8d07-4052-a6e1-1d1a802d03dc', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('86538518-593d-446c-913e-79d705d1165e', false, 'volunteer', '45692db4-c1ef-4be1-b151-f68810907a7b');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('adbd943e-f616-4c50-98bc-289334793b80', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('cb064e74-349c-4273-b55b-a27a80f0ecc1', false, 'volunteer', '45692db4-c1ef-4be1-b151-f68810907a7b');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('79ddef19-2126-4d51-a109-8cdd8968ab78', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('a05c2cb0-b85a-4967-afa5-8c16fa9020b9', false, 'volunteer', '45692db4-c1ef-4be1-b151-f68810907a7b');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('37dcc0a6-77cd-467f-acfb-2bb06b85d149', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('ce0515de-c254-4ba1-a8c2-37c012056688', false, 'volunteer', '45692db4-c1ef-4be1-b151-f68810907a7b');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('fcf7d3c9-37d5-4c9c-a047-ec2b46365c05', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('7118e2e3-124d-4cf7-956e-6fc7fe22d8fa', false, 'volunteer', '4781a80c-b298-4317-b299-e113362f9b67');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('f624d331-97bb-4a40-99d3-112ac4d6fcbf', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('5d011168-689c-4d7e-81e9-00237a877a12', false, 'volunteer', '4781a80c-b298-4317-b299-e113362f9b67');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('cf1b3608-fd01-4080-ae1b-330fc1bee480', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('099667b5-31a1-431e-9681-6feb5ad59f54', false, 'volunteer', '4781a80c-b298-4317-b299-e113362f9b67');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('0f08d6b2-4c09-4a4d-9c1a-1caffa03d06c', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('666dd326-0e04-463b-b620-ee5d2240fb69', false, 'volunteer', '4781a80c-b298-4317-b299-e113362f9b67');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('8eed8473-97a6-42de-9798-6eba05478c6e', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('ed8ecc08-46d4-4eb0-bd2d-c3a2c5608ade', false, 'volunteer', '45692db4-c1ef-4be1-b151-f68810907a7b');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('480abf52-195c-41d1-ba7e-a24215f43a4a', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('eb3ab7a2-d55c-4739-a83e-d91cfad63a32', false, 'volunteer', '4781a80c-b298-4317-b299-e113362f9b67');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('fe86aedc-6bb6-4d28-a6cf-fc2c21881fcb', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('d099b10b-1547-49ca-85e3-ca68f8f79987', false, 'volunteer', '148e125d-5934-4f5e-b17a-fe1587a57427');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('6fbbcdd2-a324-4169-9b70-f3f39ff93eaf', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('90f9749b-a463-4c47-a216-21c3006b381d', false, 'volunteer', '45692db4-c1ef-4be1-b151-f68810907a7b');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('4d5407f5-a2ea-400d-b5e3-b6fbb004fac7', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('ac2c4c0b-c124-496f-b3a1-f0766f78c17d', false, 'volunteer', '4781a80c-b298-4317-b299-e113362f9b67');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('ff1144b6-5f1b-4d15-8dc2-d2fd71cd3616', false, 'user', '4a78f729-ef25-4e03-876e-8fecd7893513');
INSERT INTO public."Token" (id, revoked, subject_type, subject_id) VALUES ('a50fe742-d77b-4428-86cf-7a0281447c2a', false, 'volunteer', '45692db4-c1ef-4be1-b151-f68810907a7b');


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."User" (password, email, credits, id) VALUES ('$2b$12$K.zniIqqyRxNHT9RaC8/xOmmTooR4aKPsXwo99vmFDIN.tdS2qUtK', 'test@gmil.com', 0, 'e93d17f7-9293-4d33-ba8b-70c9cc5ca319');
INSERT INTO public."User" (password, email, credits, id) VALUES ('$2b$12$TCVlojHC1unccM0HHxIwvuOi.v.Hc2Q.iVB3uNqME0E3wJOQXqU0e', 'testa@gmil.com', 0, 'ee7f2883-46df-41f3-bfcf-0f730e7fc984');
INSERT INTO public."User" (password, email, credits, id) VALUES ('$2b$12$YT542MjlMVKNCcbwAWCPreSMdF7ZeTqUEr5fhVI6GTBcESWdiJo.S', 'manel@gmail.com', 0, '7c39bf68-c834-4212-8cb7-fa56d6041893');
INSERT INTO public."User" (password, email, credits, id) VALUES ('$2b$12$BsVPzVGnxh04CTnugt3iDOiSLPZhp27gZpELOX0fgP7FbNAsw9vQe', 'a@a.c', 0, '94d3db0f-3ee7-42cb-809f-1d083a302b56');
INSERT INTO public."User" (password, email, credits, id) VALUES ('$2b$12$YijYh5r6aQjsVw66MtwwzOlnylLkHYefasLcLuNygxdyhXuUtVplq', 'tese@ist.com', 0, '4a78f729-ef25-4e03-876e-8fecd7893513');


--
-- Data for Name: Volunteer; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('7770c373-7885-4822-bd67-cdf7e9791dc7', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '1.1.1.1', 3000, 'FREE', '2019-08-07 16:19:19.734972', 'fc446939-9f51-43eb-a77c-3dc51c919111', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('03f2df11-f9c1-416f-aa98-d9b76f2ed76f', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '1.1.1.1', 3000, 'FREE', '2019-08-07 16:21:47.099581', '9773ec43-87d2-4d4e-b90a-8a90003651ba', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('2556706b-ed3c-4a3c-b044-acd5a8bcdeb9', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 14:47:10.381159', '47b144fa-e496-4171-911f-8d089d3c351d', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('37fe7f6a-f358-457a-b3cd-6b7f35ed3b3b', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 14:50:41.309537', 'e7bbbbda-a12a-403e-bdce-5caeae6cd685', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('87972c34-37fe-447a-a58a-c61727303834', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 14:51:13.167082', 'c7b0c9ad-dedb-4fce-afc6-72b9b7d48847', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('8fc32199-5b9d-4b3d-a609-7dc728f7da29', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 14:58:57.655536', 'f1856cc3-20e0-4780-b02a-da5a0b055d6b', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('e614ede1-872a-4e70-b29c-da202d1cde7a', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 14:59:35.602723', '6e1da60d-6a76-4aaf-b87c-1457e5fc75e9', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('b4b4fc8a-27dd-4818-bd9d-c3ee03b7e210', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 15:05:59.070019', '71bcb8fb-a898-4a8f-9119-b46f281bec07', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('16404674-7c66-466a-9cb6-ad809467d0e3', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 15:06:37.808161', '7c6ae200-d867-4aa2-ba21-af71d28b7b36', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('7fdd00a2-969b-4d53-9041-91b39047423a', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 15:11:27.299226', 'c9a62050-97c4-413b-9850-f6096dc8e5aa', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('c9b5b27d-417b-460e-93aa-c1915886dd27', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 15:11:52.657555', 'f7145877-8a44-45f8-bd9b-34fbe3ea552f', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('5faa4ff2-4e7d-47c2-b36a-d854e559884f', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 15:12:50.266378', '4ab1100f-9a55-44d2-9614-35111abdf21e', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('501cca36-a4bc-4dae-97d7-17a8ce6d69f3', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 15:13:41.38005', 'f0d23fcb-ce45-4711-90c7-729b81eda190', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('fb2f936c-eea8-41ef-a15a-b1afefb76757', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 15:14:22.23578', '503c743f-a0a9-4c84-ae0d-d8d895430dfe', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('a95344b1-acc8-47f3-ad51-9096507a9d72', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 15:15:28.575858', '4a55c366-a823-44ac-9423-76cd18e63cfe', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('ef85f657-0a63-4b68-b999-2687d5c7d878', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 15:19:12.025032', '3dfcfea1-1a96-445e-b27c-357cdc89b09e', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('95add59d-3f28-4216-970d-8f6dcb7821f7', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 15:20:08.019726', 'b4531279-65f5-4ab0-b760-875866b47cf9', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('834a4d6a-572f-40c8-82d8-859341054a02', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 15:21:47.463236', 'ea0fb1ec-39c9-4d18-af41-32e6e309b083', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('0968baf3-fb77-4feb-8b3b-7a572582eb57', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 15:34:20.625644', '00dc5f8e-e919-4f34-bad6-c153f781dd19', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('846e36ea-26a1-4f6e-864a-df12f4bd604d', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 15:34:55.233078', '8a21a727-4f80-4a0b-858a-46a25b56f597', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('3e4e5e4f-efee-4afb-8727-caf91fb088b9', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 15:36:53.24232', '637eeaa5-a3f9-4e11-835a-932f7b0f6c0e', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('c35dca0b-7720-4985-8bb7-f25a45e38f2c', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 15:38:09.003407', '38b5f251-4c30-45e1-9fe4-01725d42e766', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('df3c06a9-924c-46c1-9ddb-92b2d504db62', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 15:44:11.327731', '9f5ddca9-dadc-4c5a-ab4f-4da12adc162b', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('f4e8ea82-2246-48f9-bc50-dbf9a191d999', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 15:44:56.646221', 'd5a87d1f-6862-4ae6-b81d-471e32752d97', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('70fb6d9b-627d-41f8-ab50-749af25b598f', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 16:21:18.892297', '5243940c-ec8c-49f5-8982-d8dc0e4f13f1', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('a5581fae-a909-4ae9-bf03-b4456cefe997', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 16:35:07.423369', 'c7b86ee6-fee6-4875-bc49-5fd9e5631eb0', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('5bc80d68-58cf-4cbb-895a-3b189ec8b9a7', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 16:38:12.727024', '664df0a7-fd7e-4e6e-b733-3d3416f7f4c5', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('8fde715f-96ae-4eeb-90f2-faca31c46f35', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 16:40:43.373441', '52631ded-079a-4915-8691-c930128d8611', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('f7699d8d-cfa4-470b-a62b-a17c1dd9b010', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 16:41:31.810261', '5837f863-238d-40d6-835d-4737ca107393', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('7b16ce55-f0ab-45f5-9f9b-8efa97ccb73a', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 17:15:03.479762', '766d3c4f-8314-4247-ab0b-448eb013abcb', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('e30fdf8b-cce9-4408-add0-445fbe5798e6', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 17:15:25.184731', 'e7c43d5b-8a81-4a28-baf2-5137486ddca3', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('8d5128b2-b88a-4f55-95d4-76364aa986e8', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 17:20:57.830666', '53051644-c74d-4243-a88e-7c899ff6fc31', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('91922188-4676-4e66-80d7-d0c8b2c2c464', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 17:38:18.327193', 'c3671294-cf2b-49d9-9fb3-f506e1bf0cf3', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('09001784-5500-4ed3-b375-9ddaf6a0d7dc', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 17:40:29.24397', '7d0d9e08-8f00-4a02-b162-3aba0482d8f3', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('f1f96b45-7abc-4d53-8a23-6873572a844d', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 17:49:16.703193', '5ebbd1dc-21af-4885-a015-8af9c17ff15c', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('b6ab8fff-0a27-4e08-8596-245bafbc174e', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 22:46:34.568993', '01b22c6d-02e2-4935-b3da-5c58d6a157ee', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('7660d02d-e322-4595-87a0-44dddf725237', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 23:00:23.046521', '605c7b28-e17e-4d2f-bf27-cc4dba266893', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('cb6a8094-35f9-4eea-bcd7-149ddbc4fc53', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 23:01:24.854031', '4cf13550-fe16-4356-92e1-5900aa741243', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('f88a9f55-8828-4e14-8725-544658687622', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 23:04:32.674103', 'b7e24c31-6b19-4c13-9e72-37f311e38981', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('560702d5-93c1-449d-a76f-516654b8a19b', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 23:05:41.17226', '66cd994b-732d-46b8-8aaf-942d84daf1e9', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('46df1087-0b2f-4f46-b992-f83094e1322d', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 23:13:49.787601', '348f6d2c-ac72-455b-aa90-9fdec4ba49c1', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('d1df0fc9-aac2-4a16-87d0-3c86576ba753', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 23:15:13.387306', '945bf89c-f9ce-4e86-8385-18e3cc93279b', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('b6ec7107-4581-4d9d-8ea8-93b68487ffbe', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 23:20:56.673151', '8a3b5f86-7a01-4b16-8c32-b60e3f3bf374', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('a1406084-51c7-4e26-b2cb-3b6dd39dc6fe', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 23:23:17.664156', '5b728537-dc94-40ec-91aa-5ec545793599', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('461fc063-7042-411e-86c1-ae23ea4993ce', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 23:29:12.667711', '342f1fad-74bc-4e9d-8b6d-c220b9780101', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('1857806e-88bd-489d-9043-7560eb7cf817', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 23:31:17.831111', '93eb59f0-a598-48a2-ac5d-074133ef9adb', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('82f87756-6b26-4894-9e5b-ab16ec329019', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 23:38:07.846582', '53b6f152-ceeb-4eb3-902c-a9f287456c92', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('d541d56b-b129-488c-8938-3ad811422cb5', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 23:39:40.683323', '61ba4c85-8301-4b17-b07c-d008d6d97c06', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('695461a6-f68c-4a45-956a-3b6a233dfc09', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 23:40:38.53762', 'f544c1a2-5528-4ee8-b738-78947ca30dcc', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('0647d98e-a0f1-40cc-ae3f-21d49b6824db', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 23:41:45.240543', '6d3f142f-0a11-47d5-b888-d044773f702f', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('50f1d6d4-7d04-463e-9d57-5e38a59b024f', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 23:43:10.100938', '8048b8e4-4860-410d-bf2c-5cdb1dd76d12', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('513c8bec-87c8-4133-b9c0-ef3ba04ed6f6', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 23:43:47.26485', '130c2dd7-b722-4af0-b120-2487433204d2', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('e8eca56d-68b2-4afc-8f8d-b7ce33634666', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 23:45:13.811293', '5f71fb3d-5cc3-4c90-b91b-2c97c6d224f0', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('c8f7b4eb-ca64-4489-8f09-20099dac4f95', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 23:46:44.487076', 'a0795c55-561d-411c-9be0-ac7f78872322', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('84c81a90-fafd-4344-8b82-f0cc9426c20c', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 23:48:44.924709', '0273f5ce-8deb-44b0-9ea9-c05aeb40edcb', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('1f9fda5d-2a0b-4289-89fa-1e89a1082df5', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-23 23:50:55.767348', '05fbb125-cf4e-463d-9bd4-5bd17d87ba51', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('59bf508e-842b-4160-b13d-f013f057a8a3', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-26 00:46:10.267586', '5abea6f3-2146-4206-a895-7df58d21a939', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('4f70feca-0ea6-4578-80e9-c86997dd9d7e', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-26 00:46:25.204181', '31e07ca3-6b1c-4214-839c-b85c7c14b42f', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('a727b5f1-b234-426e-b943-1e74afc9f42e', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-26 13:48:32.452977', 'ae36b0e0-c76c-4072-a1dc-951519d347b2', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('77ae86ea-014e-4bc4-85b1-72b1a6d7e959', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-26 13:50:27.877806', 'b48a77a1-fccd-4c01-933d-8ba19fd0f548', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('f24bfccc-7386-4dde-a996-814517d6de86', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-26 14:02:51.394728', 'ce09b750-55e9-4e91-9537-e89fdae61890', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('0ef52941-eedf-4a6b-b523-eeb12b1f6c8a', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-26 14:10:04.600323', 'd6c84f9c-2ddf-4ef9-b37c-d7456fd89294', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('8864533a-a042-41e9-aff8-b1c421a532ce', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-26 14:11:02.757065', '4486b834-abb0-4de7-9cc9-b509ed2fa8bd', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('1b26bda3-a713-4afe-a6b3-7683bf8c51a1', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-26 14:14:03.43361', 'ecf2312d-13b4-4ff8-bcc3-66712d964168', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('c36716d6-bf93-4f09-bf0f-2eff0db2812e', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-26 14:14:43.396055', '58b2a3b3-645d-452f-9d1e-b4588a4bcd61', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('94155bdc-49f2-492b-b029-045dea8d142b', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-26 14:23:16.83121', '35508fa6-afab-4de2-9c64-d024c0445e11', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('126457e5-7467-448c-bded-e8cafa75c90c', '8f922414-d107-4f00-a50d-ac4c50f20d88', '127.0.0.1', 1234, 'FREE', '2019-08-26 14:33:22.878871', 'd0d4d42e-0f76-4299-8c7b-53463b930b3c', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('603cd77f-8909-44f4-9cf2-fcdcbc414b54', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff', '127.0.0.1', 1534, 'FREE', '2019-08-26 14:44:25.415387', '08d864f2-77f8-432f-8a8d-0f1a461eabcd', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('965ee055-5625-433d-ad8f-c7a5e8c44ffe', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff', '127.0.0.1', 1534, 'FREE', '2019-08-27 20:49:13.121992', 'd27c1590-e814-40cb-a026-57dfd336e0d5', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('d90be8ba-1d2d-40bb-b23f-bbd94489bdde', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff', '127.0.0.1', 1534, 'FREE', '2019-08-27 21:29:28.2463', '2e52cf82-a8b5-4165-bb8d-db56a8bdeabc', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('0b6039f7-aa3f-45a6-bcc9-13eff0d8f130', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff', '127.0.0.1', 1534, 'FREE', '2019-08-27 21:31:18.991537', 'c61f41b6-bf31-4f14-8849-e15c37eaf84e', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('ac426307-70e5-4e47-8a99-81b15304d33d', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff', '127.0.0.1', 1534, 'FREE', '2019-08-27 21:32:58.236495', 'cad772ba-f53d-4117-ae4a-77b0b0d49d2b', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('bb1ded09-ba26-4579-a1df-948db771e4bd', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff', '127.0.0.1', 1534, 'FREE', '2019-08-27 21:38:13.455242', '09e7d00f-a57d-4d75-ba4b-06ac79b32ae2', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('71225389-ae8b-4117-ac0e-4821c5f9194d', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff', '127.0.0.1', 1534, 'FREE', '2019-08-27 21:39:18.430425', '9aed2419-edbb-491f-9d0a-78c730144919', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('c090b7cb-ab5c-411c-b567-eb8eca4e7f3e', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff', '127.0.0.1', 1534, 'FREE', '2019-08-27 21:40:39.791787', 'ae511bbd-4564-4129-8ba9-eca848d5f2d5', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('5fe6d099-93e6-49fb-9e0e-81430df8de66', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff', '127.0.0.1', 1534, 'FREE', '2019-08-27 21:44:51.031754', '7f464104-645d-48d9-a37f-5b389c64d8df', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('47ec5c92-824a-4277-b64d-8d9797c4116e', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff', '127.0.0.1', 1534, 'FREE', '2019-08-27 21:47:23.879358', 'f75ffe54-1fff-48e3-aa0d-5ee974e41596', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('9ae0bb4c-74fb-4aea-b15d-974ab58cae12', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff', '127.0.0.1', 1534, 'FREE', '2019-08-27 21:48:59.230429', '745b2c35-7447-4153-b6ce-5e4cd2890c1e', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('43fd290a-2182-41ef-9176-f359c9a86c52', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff', '127.0.0.1', 1534, 'FREE', '2019-08-27 21:54:14.745074', 'a63d36c0-81f0-4d4c-b8f7-3a16ec263e9c', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('fc85f176-d7bb-488d-b649-6551a9686933', '4ca472c2-eb0a-4559-9be6-6d1339ab45ff', '127.0.0.1', 1534, 'FREE', '2019-08-27 21:57:05.306949', 'a841d382-7410-4e92-b841-a6587cf5908d', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('a3c3bbfd-52b1-4a51-a686-545bf38d9609', 'f796f16f-fc43-4016-aa96-f27af7bb7c98', '127.0.0.1', 1234, 'FREE', '2019-09-09 11:56:28.010883', '545c37fe-b25d-4cd9-8927-67c6069059d2', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('5ff81256-a8db-4a85-9bb5-b84ddcb3ff52', 'f796f16f-fc43-4016-aa96-f27af7bb7c98', '127.0.0.1', 1234, 'FREE', '2019-09-09 12:02:20.634979', 'bb48c49c-c57c-43e8-b2ae-a033c956ad3c', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('3e431f1d-6dd8-4ea2-864c-d4b769123255', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 1234, 'FREE', '2019-10-04 03:58:58.890227', '3ec5b514-484e-4f85-898e-233d8ba47ff9', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('ea339ad2-e54b-45aa-bd7f-8e1e7b116ad9', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 1234, 'FREE', '2019-10-04 04:03:12.32145', 'e5254c88-c4a6-4487-8859-cfc8a3e11b4a', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('5bb6eabf-0ed7-4480-8f14-0adf06be91dc', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 1234, 'FREE', '2019-10-04 04:04:34.749492', 'c1c94961-119b-433c-8ba0-9a121c46ca7b', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('4ca02546-be43-4c9b-9f97-b64bf522165a', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 1234, 'FREE', '2019-10-04 04:06:24.783338', '58ca300f-01a1-45f7-81ef-0ee0cecb76de', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('347a29bf-0f69-43a6-be23-93afa89761c5', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 1234, 'FREE', '2019-10-04 04:11:51.348489', '53bf254a-d06d-46a1-8972-3d77106cdc01', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('fa179cc4-7654-471f-8b38-79edf42c3eb9', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 1234, 'FREE', '2019-10-04 04:16:03.000679', '6085d8c3-83e7-48b4-a228-d7c6377b4410', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('fcb03ffd-29bb-4991-9043-9a864eec7807', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 1234, 'FREE', '2019-10-04 04:18:27.118451', '6ab453bb-0f2f-48d6-906d-bd279a7d1918', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('0a217b33-d7e0-49ac-ad3b-2e5b3cf77904', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 1234, 'FREE', '2019-10-04 04:22:02.143312', 'bf03bdbf-5c21-4cfe-807e-6364df76426a', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('75340f5f-06eb-4836-b939-f1833d83f5e4', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 1234, 'FREE', '2019-10-04 04:22:49.0019', 'a5b483fd-f734-48af-a008-2847ae4cbb6b', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('f960981a-2ea2-4037-b88c-646e5ccf1876', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 1234, 'FREE', '2019-10-04 04:23:33.446192', '73a89453-6c98-4d43-8732-68ffb38dab78', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('e48febdc-8e31-416f-8f21-32fa4cb9e0cc', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 1234, 'FREE', '2019-10-04 04:25:36.06049', '9bd1ed60-80a4-40d7-bc47-0ca498f9433c', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('aa03ce44-19b1-4a35-b660-0d51b6c1c982', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 1234, 'FREE', '2019-10-04 04:26:00.149425', '058e6a60-85b2-41a7-bb85-a192c477568f', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('b268fdfe-cb57-4ad4-95d5-9447e869a2f6', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 1234, 'FREE', '2019-10-04 04:27:07.515182', 'c2d4b1f9-86a5-4d7e-b29a-cad63d4bfad7', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('2fb7fb11-0cde-4a39-8c8d-957908e72a1e', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 1234, 'FREE', '2019-10-04 04:37:21.884656', 'eb8fa64b-e14e-41ef-89b0-19e54a53931b', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('aad3314e-cfce-4bb2-a8bb-4b48e0af22ef', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 1234, 'FREE', '2019-10-04 04:38:36.283995', 'b0578d12-ad1d-4b49-baa7-2901cf766731', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('875660ba-b2a5-4339-8fea-e17f5016dd01', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 1234, 'FREE', '2019-10-04 04:39:50.40417', '472c3cc7-581d-404f-84ce-39aad1931fb2', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('63bbd1e9-3717-4c0e-aaef-aeafa8dd7b35', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 1234, 'FREE', '2019-10-04 04:40:05.379017', '74acf245-f8fe-4b1c-8b27-7ae28eca1f36', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('8b1356c9-cd5a-4597-9d07-aa930f2ad31a', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 04:40:29.910835', 'c4f931eb-9fb6-4525-8cec-64fed28f91ef', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('b6f10719-cee4-434c-a415-469aba47c78c', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 04:44:29.175277', 'cf5d8a0d-3e9b-4caa-aa32-01b748d1104b', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('b7feb1a0-14c7-4a0a-9bfd-fd5bb1a881c2', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 04:46:14.211227', '447c47e8-100f-47ea-ba8f-71126423bf37', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('acbdf953-6c51-408e-abfc-1262f18e1a14', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 04:49:14.298322', '2ed91ef8-d13f-4e1d-a307-4209364011f8', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('0030eb87-6a5e-4cb3-a3f4-a02a69ff8f35', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 04:52:54.129028', '101d2457-bd1e-4fdf-8725-1983a23d7770', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('75479679-c49d-4ab1-ae10-5cc4e6744a50', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 04:59:07.953774', 'dfad9611-0cc5-4179-84c8-0b26b9342ae5', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('aff13008-5498-455b-b6cb-9786891fbe1f', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 05:00:38.479821', 'b9cbb7cd-4550-4131-8a52-8ac2d2fb6ebf', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('22e6e605-2262-4ae7-95c7-ee84e7b5ce20', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 05:02:20.05485', 'd777a718-95d5-4294-8e07-ed28e3c4ee63', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('6fb5cc4c-30b6-456d-a00e-512c89a7f870', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 05:04:38.219924', 'ef3d0106-84db-4979-89f0-4146ddb74391', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('c64cc5cf-036b-4e43-8e62-25f1631e055a', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 05:06:24.877031', '21c876b2-2164-4d51-8d6a-e8716184d6d5', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('78d96ed2-154e-456a-887c-f3fa7eab9991', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 05:18:39.833799', 'b722813d-8793-4a42-877b-b225bbb4604e', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('2ade8182-2390-4e3b-996c-e4b737f3c9f7', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 05:21:16.997062', '8561a35f-d99c-43a9-8679-343f5ff42dba', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('43b47b88-a32f-40e5-93f2-7cf2a0ecb3fc', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 05:24:28.319522', '189d0368-aefa-45cc-ab19-7648be08f6e0', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('a8ea3cbc-2426-4f8e-92c9-67537ba264c9', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 05:25:55.468442', '9efdd88a-948b-4677-bd44-ef1f0ed340ce', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('9034d29f-f001-42ed-a10a-e92c0cb9dcf0', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 05:29:45.217434', '7f10e89c-35a5-4ee1-98ce-7aee399ae85e', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('1df51e77-e48a-4852-a6f5-1a43baf95e48', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 05:42:58.541884', '74b73f40-f246-4069-868b-70f0b35560a0', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('62b0489b-1796-4fc8-87bd-7dd7a14a4dbc', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 05:47:06.921567', 'ebe0c9d8-294e-42d3-8f03-f20a0d2c3a07', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('1c660358-9929-4181-b89f-93babf053bfe', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 05:49:09.377771', '01b49286-9fba-4d98-9d0c-0c9ee9a7b46a', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('7c26201f-9147-4760-b396-cf6295789bdf', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 05:54:34.585502', 'aa46ec67-ca00-4092-9e33-3ca5f864d229', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('9f0faa65-6516-45a7-8e94-23c8d2580380', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 05:56:03.137941', '90418f61-1bbd-462c-afb7-d19f5e2e80d1', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('b16039ad-e35b-4937-bd6f-bec1189ed5ac', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 05:59:48.715839', '8575d29f-d60a-45d3-9ec9-3ba52b4f5ce7', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('96029e44-fd8e-4d64-bdc9-e365d08dba47', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 06:03:16.193598', 'df4fb4d7-8938-4b77-8e72-462e967e7a76', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('c18149bd-0837-4c7c-8afc-c82b69ac4934', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 06:03:30.920702', '743d460e-1369-424f-9c24-5e0aeb08fe28', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('337ad2c9-e7f6-4de2-b59f-531579a1a1bd', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 06:04:49.669513', '08ea89cc-3482-4fc9-9ce8-b9b681cfa447', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('f4fd5234-d09b-4e1c-ac51-dffc814b1a10', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 06:07:11.439832', 'f157a5c1-3e60-4283-8f64-35d59a5efd44', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('32c1494d-1ed7-4408-9591-d5e78b065bc5', '2dd34e15-27ce-44f0-aa7a-1c6e6deea987', '127.0.0.1', 12345, 'FREE', '2019-10-04 06:09:27.535427', '67c97a6e-9918-44ea-85a0-3bf1d03af070', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('cbe62a88-f926-494c-8480-f543f9bbdd70', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-14 07:26:14.900195', '77a3a804-c29d-4022-b05c-08fcf2a0a8f0', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('f0ef1144-f872-4837-8c24-24fda982c788', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-14 07:27:03.630821', '339b9752-b27e-48ee-a64c-c4a77f43fcdc', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('d4ceea07-e268-42f4-9348-9072d00b02fe', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-14 07:42:28.050915', '2aeecf54-bc71-45e7-9e39-db345ea9f2a1', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('8cffb493-d2f8-43d7-815c-7aecb943667c', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-14 08:46:01.990818', 'e4b801b4-8604-4e96-8a4f-7a6051ebf0b6', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('b0ee79f5-73b3-48fe-8de6-ef2611892a63', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-14 08:52:02.638869', '36505d52-4b57-4cc2-87a5-e88619e001b8', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('d04ad638-bf60-42e8-a120-92cae237fd88', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-14 08:52:22.896524', 'ac709ec3-2f1c-413a-a98e-308aabe4929c', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('7e917a48-1b4b-43e4-ae7f-1c3592d996d2', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-14 09:20:45.501482', '340b45e0-169e-48ef-bf39-8c93149cb0e9', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('724bf83f-b316-468c-bdf9-44502c8885f5', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-14 09:23:04.184076', '69460182-2100-4568-867a-b317db1a5f6e', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('82b4b125-2ccc-4726-bb53-1178b24c206e', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-14 09:29:27.244436', 'e31c459a-d9fe-456c-b83f-200f5c293ef9', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('ca3e466c-0a03-4a0c-973a-4a38a6efcfb4', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-14 09:33:41.710577', 'efd7a28d-c1a7-4868-85d2-835797065a51', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('89ab41ca-365d-4066-a32d-90ba34dbd327', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-14 09:48:36.408023', 'ccfd68a6-acdb-4953-89c4-e0bfff0b0e25', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('721ce8b8-2916-4a5c-a06a-a99e4a053142', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-14 09:50:46.765708', 'c9d1a18a-e412-4dbb-a886-3b483707e11e', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('ccb8aa7d-f09c-4b8b-8aae-bb36a0d04539', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-14 09:54:54.635886', 'c723921b-e630-4163-8e55-c91922d49817', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('72acb7a4-0108-4307-a3b8-98d137d9e331', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-14 09:57:59.348897', '0063f005-e8c3-4b39-9c98-ffffd499e2fc', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('13c949ce-880c-4b63-a048-53c2bdf340b5', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-14 10:01:08.488902', '29c9ba5a-84e4-480e-bcd6-0df948b5a4c4', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('bda00485-1df7-4a6d-8007-5e356e727711', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-14 10:02:48.22541', 'a6c981bd-7c26-4692-a6ea-ef1bb4963567', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('7c62e0a6-da4b-4b33-ad56-149e8ca3647b', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-14 10:08:27.061126', '7afdaf4c-4147-46ce-903c-c6a80c499ad4', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('8a28a673-75f0-4a2a-9e55-56d7f685f977', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-14 10:20:51.31689', '2d09962d-8d2d-4506-81e6-8b25f20d2eb3', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('8f5b8f70-4f52-4f16-8ae8-61107e3c3958', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-14 10:23:22.520718', '24487dfe-219d-498b-baa9-aecc1d13526a', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('aa12ba90-dc19-4cac-88e9-505c7e643dac', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-14 10:48:17.70016', '62d2e90a-2f46-441c-97d0-222fc5f3ce6b', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('72e803ba-7004-4d69-bba3-d040392b116d', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-15 07:43:55.303267', '98a2bd08-bcaf-4351-8c7f-03c207fa57f7', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('2f58e181-a7db-4fbe-845b-9ff5247c9609', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-15 07:48:27.077678', '01ea5c2c-d4ca-4032-9b70-2f7ef45a5821', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('54490f66-dfa0-41c9-9bc0-4459d78057db', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-15 07:49:47.533919', 'c1c07d57-1298-43bc-94ff-66d5f1815db1', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('613d0042-36c6-468a-8016-67d3470f307c', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-15 07:56:30.113718', '26cb9435-db7f-4e5d-afdd-97501052bf54', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('17a1977a-6a62-4e39-a5cf-2573ec789187', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-17 08:49:02.179007', 'fcbb6a63-f623-4335-8135-aa14d4437aa5', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('d0d3aa1f-3f1e-4f52-8154-941d983ed4d6', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-17 08:55:15.034371', '512ec685-c58d-4f01-8835-43828c783912', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('ca5da3fb-7d4b-4303-9718-7b4be8149df7', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-17 08:57:37.252789', '94fa8a85-96c6-4b44-8d17-76501c861c89', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('4141b26a-9c06-45eb-8e0c-f21ab3610578', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-17 11:42:07.663109', 'a5b9b54d-1edd-4260-b9c3-7a2e699da407', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('aef0878d-4910-4263-b3e5-e6df4c087d98', 'e0f9aaca-53c3-4039-826e-a999a844fe6f', '127.0.0.1', 1234, 'FREE', '2019-11-17 11:53:01.502051', '87bb177f-112c-433d-92a3-1c1ff7542708', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('4247b673-f4ef-4ff7-8269-581b59e4eccb', '63f53e57-8c58-4d36-bc50-b41d145de0cc', '127.0.0.1', 1234, 'FREE', '2020-07-22 00:47:31.570776', 'abfd3e8e-f583-485a-926b-b419efed47bb', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('7f118bc6-6d56-4692-bb11-706e2f77eb97', '45692db4-c1ef-4be1-b151-f68810907a7b', '127.0.0.1', 8201, 'FREE', '2020-07-22 00:48:48.156681', 'b85df120-e90d-43d0-ada8-6652c7aa4e15', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('2487078e-f17b-4cfe-9275-c9644e9e47ed', '45692db4-c1ef-4be1-b151-f68810907a7b', '127.0.0.1', 8201, 'FREE', '2020-07-22 00:59:41.484564', '11854148-8a92-4f33-b5a5-ff2438b99bcd', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('f592e6aa-dde0-430c-9313-1168ad2995cc', '45692db4-c1ef-4be1-b151-f68810907a7b', '127.0.0.1', 8201, 'FREE', '2020-07-22 00:59:41.5046', '0cedc62f-3cc8-4ea3-8d53-465dbd0797fb', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('58ed5524-ee47-406a-93a8-3ef2f3c2ec5b', '45692db4-c1ef-4be1-b151-f68810907a7b', '127.0.0.1', 8201, 'FREE', '2020-07-22 00:59:41.504701', '6b10b6cf-8b58-430d-8a4e-2f9d60afab4f', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('08d8682a-57fb-427d-84a6-22bca6c472f8', '4781a80c-b298-4317-b299-e113362f9b67', '127.0.0.1', 8202, 'FREE', '2020-07-22 01:00:05.874747', '71de8baf-3190-4afd-b344-276e75dfa43c', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('cf6ec7a2-6b11-49be-ba72-7861eebf13eb', '148e125d-5934-4f5e-b17a-fe1587a57427', '127.0.0.1', 8203, 'FREE', '2020-07-22 01:00:55.53793', '9319ccd9-c6b6-4ffa-9cbe-d1f08d31a4b7', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('0bc05d1f-5a70-4a9d-b972-cdf5e37dc89b', '8f24fb90-24c1-4cd8-a31b-ddefb3d7937a', '127.0.0.1', 8204, 'FREE', '2020-07-22 01:00:57.402518', 'bda7d0aa-7864-4f6f-919e-9b8b0e14cdbd', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('851bcc5c-5f08-4714-bc53-09a1818df937', '4db49ed0-3a70-4b1a-8af1-7936f26729bc', '127.0.0.1', 8205, 'FREE', '2020-07-22 01:00:58.313465', '96906413-952f-4ecb-9950-8b61143aac5b', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('6648f09c-1be2-407b-a193-f2e5997f888a', '297a3248-499f-453f-9391-d5dded0ae790', '127.0.0.1', 8206, 'FREE', '2020-07-22 01:00:58.942486', '6f035a70-ef3b-482f-a3e3-4f98519b22de', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('112df797-0763-422a-ab8d-a0e3594f8299', 'f84dcd9f-fd0f-43e9-9f4b-8042b4b7f0af', '127.0.0.1', 8207, 'FREE', '2020-07-22 01:00:59.062406', '96b72562-fec2-40ce-a65a-82c08ffff205', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('c8b384c3-4081-4595-b795-b71754aa8219', '45692db4-c1ef-4be1-b151-f68810907a7b', '127.0.0.1', 8201, 'FREE', '2020-07-22 01:06:43.676196', '4a992ec9-11d1-45d8-b1bd-9b53e93d136a', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('ef0e6531-d75d-4869-8f51-0a1fe1834eff', '4781a80c-b298-4317-b299-e113362f9b67', '127.0.0.1', 8202, 'FREE', '2020-07-22 01:06:51.522903', '7c1bb4f3-d830-4f05-b564-9f4976ef5f0f', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('5f61f083-99d4-4eea-b1d7-ebf25ba0dada', '148e125d-5934-4f5e-b17a-fe1587a57427', '127.0.0.1', 8203, 'FREE', '2020-07-22 01:06:53.423189', 'ce30b760-b49b-4224-a6ef-5b05f680918e', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('9ef5540e-cf21-4c7f-9870-6fd4ea347938', '8f24fb90-24c1-4cd8-a31b-ddefb3d7937a', '127.0.0.1', 8204, 'FREE', '2020-07-22 01:07:19.935935', '662884c2-e2be-4d9f-8c24-6896c055cbb1', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('f341032b-48c5-48a2-9edd-5e1380656bd3', '4db49ed0-3a70-4b1a-8af1-7936f26729bc', '127.0.0.1', 8205, 'FREE', '2020-07-22 01:07:41.211739', 'e2023938-ce03-4bfa-9c03-bcf730f70895', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('9fcf3c5c-c95b-4645-8d8a-c489783e0e66', '297a3248-499f-453f-9391-d5dded0ae790', '127.0.0.1', 8206, 'FREE', '2020-07-22 01:08:02.113405', 'c66e9c0c-d69c-426e-8783-05b607364d4e', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('b56aff70-13a6-4e1c-95af-451450947b49', 'f84dcd9f-fd0f-43e9-9f4b-8042b4b7f0af', '127.0.0.1', 8207, 'FREE', '2020-07-22 01:08:19.224843', '043a5adc-e44f-4e9a-bf7d-bd184ae6fa10', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('17855860-5dc8-4638-aa27-d772b043e9c7', 'a5ce847a-5405-4260-966c-3faa54456fbf', '127.0.0.1', 8208, 'FREE', '2020-07-22 01:08:37.882964', 'ef52c486-3a6e-47b6-8d7b-53ce9398af70', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('b3c89bd5-e8b7-4464-88ee-0009756a6c5e', '45692db4-c1ef-4be1-b151-f68810907a7b', '127.0.0.1', 8201, 'FREE', '2020-07-22 01:11:40.021469', '7d46827e-9278-416a-ae45-44d1f28debad', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('419e1ff7-5377-41a6-a1b9-b1b02fb0ea0e', '45692db4-c1ef-4be1-b151-f68810907a7b', '127.0.0.1', 8201, 'FREE', '2020-07-22 01:17:11.170088', '560c9847-8571-43f6-93ad-089a4c87c7b6', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('9d8e87ba-f4ad-4fab-b9e9-a43785583846', '4781a80c-b298-4317-b299-e113362f9b67', '127.0.0.1', 8202, 'FREE', '2020-07-22 02:46:19.802426', '058332cf-95e9-4e59-97c1-3ed767aaecf4', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('15682aa0-9170-45c2-a947-73a060a5b413', '4781a80c-b298-4317-b299-e113362f9b67', '127.0.0.1', 8202, 'FREE', '2020-07-22 02:51:38.567092', '32bed62b-0d66-44f4-9092-6a586fd248a1', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('fb4e5222-8167-4262-a14b-01a3a7168795', '45692db4-c1ef-4be1-b151-f68810907a7b', '127.0.0.1', 8201, 'FREE', '2020-07-22 03:22:29.996899', '72b73076-3e2b-4711-9f6f-0a9ee58cba63', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('163c68da-e433-4037-9dad-647a318061bf', '45692db4-c1ef-4be1-b151-f68810907a7b', '127.0.0.1', 8201, 'FREE', '2020-07-22 03:24:24.894974', 'a80efad9-cb19-4b9d-a28d-23c4e7596f8f', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('23c593a1-ac65-44f7-8042-7fcad2128085', '45692db4-c1ef-4be1-b151-f68810907a7b', '127.0.0.1', 8201, 'FREE', '2020-07-22 03:33:46.746562', '0206883c-b3d7-45ca-bb1a-bdea878dd657', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('4d7c02f7-8549-4346-891f-8735b0ed188c', '45692db4-c1ef-4be1-b151-f68810907a7b', '127.0.0.1', 8201, 'FREE', '2020-07-22 03:37:43.936969', '53bbd2fb-d059-48bf-804d-444c84818007', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('763fdc01-560c-4bcb-954d-89de339174c0', '45692db4-c1ef-4be1-b151-f68810907a7b', '127.0.0.1', 8201, 'FREE', '2020-07-22 03:40:27.761024', '11bfebeb-c8d3-45b2-9844-4f51ea8e69a2', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('f0d23f60-c4dd-4d57-bbe8-64e0cec6649b', '45692db4-c1ef-4be1-b151-f68810907a7b', '127.0.0.1', 8201, 'FREE', '2020-07-22 03:51:46.435819', '86538518-593d-446c-913e-79d705d1165e', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('1e6ac685-194d-4505-9698-d21cf46f4a29', '45692db4-c1ef-4be1-b151-f68810907a7b', '127.0.0.1', 8201, 'FREE', '2020-07-22 03:52:21.155386', 'cb064e74-349c-4273-b55b-a27a80f0ecc1', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('88599360-b74e-463d-a8e5-566274aa051a', '45692db4-c1ef-4be1-b151-f68810907a7b', '127.0.0.1', 8201, 'FREE', '2020-07-22 04:14:34.896565', 'a05c2cb0-b85a-4967-afa5-8c16fa9020b9', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('da5734ce-132a-4da4-8631-186c0f483943', '45692db4-c1ef-4be1-b151-f68810907a7b', '127.0.0.1', 8201, 'FREE', '2020-07-22 04:20:15.919045', 'ce0515de-c254-4ba1-a8c2-37c012056688', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('38231d7c-5579-423c-a7ae-f20b947368a4', '4781a80c-b298-4317-b299-e113362f9b67', '127.0.0.1', 8202, 'FREE', '2020-07-22 04:33:06.724628', '7118e2e3-124d-4cf7-956e-6fc7fe22d8fa', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('9b9370a0-8b2b-45e4-86ad-00f47dcb06e3', '4781a80c-b298-4317-b299-e113362f9b67', '127.0.0.1', 8202, 'FREE', '2020-07-22 04:36:47.854977', '5d011168-689c-4d7e-81e9-00237a877a12', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('bf0359d4-21ae-4151-8279-01c73c8470cd', '4781a80c-b298-4317-b299-e113362f9b67', '127.0.0.1', 8202, 'FREE', '2020-07-22 04:37:30.694269', '099667b5-31a1-431e-9681-6feb5ad59f54', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('e1d641d0-f0bf-4c04-97bd-5048328d0cd1', '4781a80c-b298-4317-b299-e113362f9b67', '127.0.0.1', 8202, 'FREE', '2020-07-22 04:37:39.63419', '666dd326-0e04-463b-b620-ee5d2240fb69', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('e51c420c-ecb0-4dd4-ba38-a17c3e38c1f2', '45692db4-c1ef-4be1-b151-f68810907a7b', '127.0.0.1', 8201, 'FREE', '2020-07-22 04:38:22.418437', 'ed8ecc08-46d4-4eb0-bd2d-c3a2c5608ade', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('0abb0fda-cfb7-4ba9-994b-e822cdcd7a27', '4781a80c-b298-4317-b299-e113362f9b67', '127.0.0.1', 8202, 'FREE', '2020-07-22 04:39:13.643788', 'eb3ab7a2-d55c-4739-a83e-d91cfad63a32', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('58b93da5-25a4-448c-8140-a4534cfd254f', '148e125d-5934-4f5e-b17a-fe1587a57427', '127.0.0.1', 8203, 'FREE', '2020-07-22 04:39:14.823286', 'd099b10b-1547-49ca-85e3-ca68f8f79987', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('d0f6047a-4183-4c5f-a7fa-30724d34e471', '45692db4-c1ef-4be1-b151-f68810907a7b', '127.0.0.1', 8201, 'FREE', '2020-07-22 04:39:48.121033', '90f9749b-a463-4c47-a216-21c3006b381d', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('a44402f6-8009-45fb-b8bf-0c44cfb8d9fc', '4781a80c-b298-4317-b299-e113362f9b67', '127.0.0.1', 8202, 'FREE', '2020-07-22 04:42:12.164245', 'ac2c4c0b-c124-496f-b3a1-f0766f78c17d', false, false);
INSERT INTO public."Volunteer" (id, machine_id, ip, port, state, created_at, session_id, stoped, timeouted) VALUES ('32d2b3dc-95d2-4edb-a75a-ab27bf0caa6a', '45692db4-c1ef-4be1-b151-f68810907a7b', '127.0.0.1', 8201, 'FREE', '2020-07-22 16:42:23.835424', 'a50fe742-d77b-4428-86cf-7a0281447c2a', false, false);


--
-- Data for Name: hearthz; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: partial_results; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('4b5ef481-a5d4-44f3-88a1-0bf13154c1a6', 'fibvals', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000e0000000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:42:42.604823');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('bb9c4d47-c61d-4c78-9201-c6388aa337e8', 'fibvals', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000e0000000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:42:42.760374');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('75f4b06c-6504-428c-b800-22b985250532', 'fibvals', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:42:42.828453');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('81979287-b22b-4316-a2ad-7e1f2df282d6', 'fibvals', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:42:43.030536');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('a99e1999-54e3-4be2-bcf5-aa6b1cc12a22', 'fibvals', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:42:43.069232');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('b12d6527-525b-4c4c-9da6-4934cd2aaf23', 'i', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a00000003000306010003050000000006435031323532000000fe', '2019-11-17 11:42:43.110999');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('0511dfc3-70c1-4132-a7a4-cab3ea8aceaf', 'i', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000d0000000100000003', '2019-11-17 11:42:43.179746');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('df041746-ff4c-49d4-896f-8dffd663a53f', 'fibvals', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:42:53.463006');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('e51b1c4b-deae-4702-af49-9321cfdb9d29', 'fibvals', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff000000000000040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:42:53.495162');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('c1220df7-de0c-4177-9132-a4003e5c4b09', 'i', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000d0000000100000004', '2019-11-17 11:42:53.536012');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('919d5ff0-9f66-439d-81a3-fd610543f42b', 'fibvals', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff000000000000040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:43:03.794019');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('24cbe6e0-c562-4759-bf5e-6c15d27e0d30', 'fibvals', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff000000000000040000000000000004008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:43:03.867748');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('fd025cc6-d74a-4308-82b7-be7f573c3942', 'i', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000d0000000100000005', '2019-11-17 11:43:03.947098');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('064850cf-a541-482b-8f44-5f8b7ad57f46', 'fibvals', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff000000000000040000000000000004008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:43:14.244006');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('2e1e758e-94cb-48a6-b360-08f3c1c01cfe', 'fibvals', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff000000000000040000000000000004008000000000000401400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:43:14.280468');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('0bc78cbd-d82f-4d52-8950-6f2133576740', 'i', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000d0000000100000006', '2019-11-17 11:43:14.312675');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('49680ce4-c851-4571-876d-355dd5210c50', 'fibvals', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff000000000000040000000000000004008000000000000401400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:43:24.571897');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('72ad08cc-252c-4de8-8d75-f492083d9c32', 'fibvals', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff000000000000040000000000000004008000000000000401400000000000040200000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:43:24.616222');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('1375add1-bc55-4abc-bd69-8d1dde95c482', 'i', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000d0000000100000007', '2019-11-17 11:43:24.846906');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('cdc443ca-eb35-40b6-94c3-684a110eb1b9', 'fibvals', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff000000000000040000000000000004008000000000000401400000000000040200000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:43:35.1022');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('ee1a2144-0ec0-4386-843f-4f9661d66832', 'fibvals', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff00000000000004000000000000000400800000000000040140000000000004020000000000000402a000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:43:35.156433');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('6b44a72d-9741-42a7-9209-4edf58f77825', 'i', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000d0000000100000008', '2019-11-17 11:43:35.189472');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('e44cdc22-ad6a-4d79-865a-b65a8ddb120f', 'fibvals', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff00000000000004000000000000000400800000000000040140000000000004020000000000000402a000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:43:45.462901');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('29e8f806-0cd0-4b4f-821a-585f65f72645', 'fibvals', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff00000000000004000000000000000400800000000000040140000000000004020000000000000402a000000000000403500000000000000000000000000000000000000000000', '2019-11-17 11:43:45.53281');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('93803f62-a8ba-4df5-9338-0c7073c694c1', 'i', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000d0000000100000009', '2019-11-17 11:43:45.564983');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('e48b6549-d2da-4303-8aa4-a66998575824', 'fibvals', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff00000000000004000000000000000400800000000000040140000000000004020000000000000402a000000000000403500000000000000000000000000000000000000000000', '2019-11-17 11:43:55.825605');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('e1a31ace-16a3-4bd9-aa05-20e5fae9277e', 'fibvals', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff00000000000004000000000000000400800000000000040140000000000004020000000000000402a000000000000403500000000000040410000000000000000000000000000', '2019-11-17 11:43:55.857869');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('7ea6845d-aece-4327-9258-d820db646124', 'i', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000d000000010000000a', '2019-11-17 11:43:55.920981');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('33b2beec-c4fd-4c8a-a697-e48581d57360', 'fibvals', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff00000000000004000000000000000400800000000000040140000000000004020000000000000402a000000000000403500000000000040410000000000000000000000000000', '2019-11-17 11:44:06.199226');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('b859ca23-40ab-4f5d-970f-3cfa53910c4d', 'fibvals', 'd3c8767d-dfe0-4457-83c0-29d78be0e45f', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff00000000000004000000000000000400800000000000040140000000000004020000000000000402a00000000000040350000000000004041000000000000404b800000000000', '2019-11-17 11:44:06.609467');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('904ce1d0-6e1e-42bb-b9f9-d7ad95340a2c', 'fibvals', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000e0000000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:53:14.694675');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('426349c5-7c76-4899-93ed-89aa3d1c8767', 'fibvals', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000e0000000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:53:14.793332');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('cbf0ee87-5309-4f25-bf2a-48526ebaa731', 'fibvals', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:53:14.832789');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('cbd6e08f-e76a-4f83-86de-7d1e1c0fbfff', 'fibvals', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:53:14.975822');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('44cfafdc-30f5-475a-b23f-83673b91a361', 'fibvals', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:53:15.014984');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('b3458d02-0c6d-47cf-8843-bd35c8032a0c', 'i', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a00000003000306010003050000000006435031323532000000fe', '2019-11-17 11:53:15.053646');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('f323ed82-9531-4125-9004-fc5e0bb062a2', 'i', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000d0000000100000003', '2019-11-17 11:53:15.120816');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('eba563d1-28c5-44d9-96c6-223fbbc85a0b', 'fibvals', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:53:25.374754');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('c0c95144-6e93-47bd-9f9b-3e4f11576135', 'fibvals', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff000000000000040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:53:25.40943');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('aa9ad09c-81dc-47da-a508-132f98a6846a', 'i', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000d0000000100000004', '2019-11-17 11:53:25.457303');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('55f8b33b-b804-4804-ac52-5507bc857461', 'fibvals', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff000000000000040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:53:35.716449');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('6e8f78ad-d0cd-4055-98c0-981eb8b37787', 'fibvals', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff000000000000040000000000000004008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:53:35.752966');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('d207b43a-09c1-43a6-91b2-72afa1c64496', 'i', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000d0000000100000005', '2019-11-17 11:53:35.785813');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('6cea1f22-3b3e-4968-9f7c-6aff6d5921f8', 'fibvals', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff000000000000040000000000000004008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:53:46.042572');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('f6ba7269-5bbf-4975-8adb-95d625f632de', 'fibvals', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff000000000000040000000000000004008000000000000401400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:53:46.069624');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('4e845b85-b324-4330-af10-a87a980e9671', 'i', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000d0000000100000006', '2019-11-17 11:53:46.109649');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('f0219865-85cb-4ad1-b2aa-daf23da837ab', 'fibvals', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff000000000000040000000000000004008000000000000401400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:53:56.40985');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('e4af9d90-2d8c-4cd7-b628-db50cbb17968', 'fibvals', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff000000000000040000000000000004008000000000000401400000000000040200000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:53:56.444858');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('aa8e14bf-4c45-40e5-b7b0-5d0eed118a35', 'i', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000d0000000100000007', '2019-11-17 11:53:56.480429');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('0da5bc06-90a9-44fe-b2a2-9ea2a41bdb9b', 'fibvals', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff000000000000040000000000000004008000000000000401400000000000040200000000000000000000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:54:06.730355');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('f2208fe0-22c2-4cec-95cc-3ee435a4046b', 'fibvals', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff00000000000004000000000000000400800000000000040140000000000004020000000000000402a000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:54:06.800014');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('cf887a62-003a-4837-91ca-8e0abaacbfb1', 'i', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000d0000000100000008', '2019-11-17 11:54:06.86386');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('69924ed2-6ad2-413f-b2cb-3bb5f5a97f22', 'fibvals', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff00000000000004000000000000000400800000000000040140000000000004020000000000000402a000000000000000000000000000000000000000000000000000000000000', '2019-11-17 11:54:17.219101');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('ae603896-9595-41b4-a216-3405a2da2a38', 'fibvals', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff00000000000004000000000000000400800000000000040140000000000004020000000000000402a000000000000403500000000000000000000000000000000000000000000', '2019-11-17 11:54:17.430489');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('437f78b5-a1ab-4d6f-ad03-95db87111c8b', 'i', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000d0000000100000009', '2019-11-17 11:54:17.503627');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('1d07125a-07d5-49a3-a973-fb37e243fae5', 'fibvals', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff00000000000004000000000000000400800000000000040140000000000004020000000000000402a000000000000403500000000000000000000000000000000000000000000', '2019-11-17 11:54:27.790318');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('69a0db10-24ba-4e58-bf8b-c8a24ffd2ed4', 'fibvals', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff00000000000004000000000000000400800000000000040140000000000004020000000000000402a000000000000403500000000000040410000000000000000000000000000', '2019-11-17 11:54:27.851372');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('2845c0e5-559d-41b4-8298-5ab35cc57926', 'i', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000d000000010000000a', '2019-11-17 11:54:27.908363');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('6aabd013-5936-4514-8b18-9ab9809c323e', 'fibvals', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff00000000000004000000000000000400800000000000040140000000000004020000000000000402a000000000000403500000000000040410000000000000000000000000000', '2019-11-17 11:54:38.197468');
INSERT INTO public.partial_results (id, name, job_id, value, created_at) VALUES ('c4344fc2-4d11-4cd5-8954-d0989fcc796b', 'fibvals', 'e039f7c6-edba-4758-8806-e72f53720176', '\x580a000000030003060100030500000000064350313235320000000e0000000a3ff00000000000003ff00000000000004000000000000000400800000000000040140000000000004020000000000000402a00000000000040350000000000004041000000000000404b800000000000', '2019-11-17 11:54:38.240615');


--
-- Data for Name: peer; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.peer (peer_id, super_peer_id, disk, credits, host, cpu, ram, created_at, port) VALUES ('4781a80c-b298-4317-b299-e113362f9b67', '4781a80c-b298-4317-b299-e113362f9b67', 12622553, 40, 'localhost', 987669776, 1448362, '2020-07-22 04:42:25.528154+00', 8202);
INSERT INTO public.peer (peer_id, super_peer_id, disk, credits, host, cpu, ram, created_at, port) VALUES ('148e125d-5934-4f5e-b17a-fe1587a57427', '148e125d-5934-4f5e-b17a-fe1587a57427', 6720850, 18, 'localhost', 833510607, 10985026, '2020-07-22 04:39:23.802854+00', 8203);
INSERT INTO public.peer (peer_id, super_peer_id, disk, credits, host, cpu, ram, created_at, port) VALUES ('45692db4-c1ef-4be1-b151-f68810907a7b', '45692db4-c1ef-4be1-b151-f68810907a7b', 681503, 8, 'localhost', 171567970, 18339403, '2020-07-22 16:44:26.390567+00', 8201);


--
-- Name: hearthz hearthz_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hearthz
    ADD CONSTRAINT hearthz_pkey PRIMARY KEY ("timestamp", machine_id);


--
-- Name: Job job_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Job"
    ADD CONSTRAINT job_pk PRIMARY KEY (id);


--
-- Name: Machine machine_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Machine"
    ADD CONSTRAINT machine_pk PRIMARY KEY (id);


--
-- Name: peer peer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peer
    ADD CONSTRAINT peer_pkey PRIMARY KEY (peer_id, super_peer_id);


--
-- Name: Token token_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Token"
    ADD CONSTRAINT token_pk PRIMARY KEY (id);


--
-- Name: User user_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT user_pk PRIMARY KEY (id);


--
-- Name: Volunteer volunteer_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Volunteer"
    ADD CONSTRAINT volunteer_pk PRIMARY KEY (id);


--
-- Name: hearthz_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX hearthz_timestamp_idx ON public.hearthz USING btree ("timestamp" DESC);


--
-- Name: machine_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX machine_id_uindex ON public."Machine" USING btree (id);


--
-- Name: token_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX token_id_uindex ON public."Token" USING btree (id);


--
-- Name: hearthz hearthz_machine_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hearthz
    ADD CONSTRAINT hearthz_machine_id_fk FOREIGN KEY (machine_id) REFERENCES public."Machine"(id);


--
-- Name: hearthz hearthz_token_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hearthz
    ADD CONSTRAINT hearthz_token_id_fk FOREIGN KEY (session_id) REFERENCES public."Token"(id);


--
-- Name: Job job_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Job"
    ADD CONSTRAINT job_user_id_fk FOREIGN KEY (user_id) REFERENCES public."User"(id);


--
-- Name: Machine machine_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Machine"
    ADD CONSTRAINT machine_user_id_fk FOREIGN KEY (user_id) REFERENCES public."User"(id);


--
-- Name: peer peer_machine_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peer
    ADD CONSTRAINT peer_machine_id_fk FOREIGN KEY (peer_id) REFERENCES public."Machine"(id);


--
-- Name: peer peer_machine_id_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peer
    ADD CONSTRAINT peer_machine_id_fk_2 FOREIGN KEY (super_peer_id) REFERENCES public."Machine"(id);


--
-- Name: Volunteer volunteer_machine_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Volunteer"
    ADD CONSTRAINT volunteer_machine_id_fk FOREIGN KEY (machine_id) REFERENCES public."Machine"(id);


--
-- Name: Volunteer volunteer_token_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Volunteer"
    ADD CONSTRAINT volunteer_token_id_fk FOREIGN KEY (session_id) REFERENCES public."Token"(id);


--
-- PostgreSQL database dump complete
--


--
-- Name: volunteer_beats_per_minute; Type: VIEW; Schema: public; Owner: postgres
--

SELECT create_hypertable('hearthz', 'timestamp');


CREATE  VIEW public.volunteer_beats_per_minute
WITH (timescaledb.continuous) AS
 SELECT time_bucket(INTERVAL '1 minute', timestamp) as bucket,
    hearthz.machine_id,
    hearthz.session_id,
    count(*) AS number,
    avg("CPU") AS cpu,
    avg(disc)AS disc,
    avg("RAM") AS ram,
    avg(network) AS network
   FROM hearthz
  GROUP BY bucket, hearthz.session_id, hearthz.machine_id;


ALTER TABLE public.volunteer_beats_per_minute OWNER TO postgres;

